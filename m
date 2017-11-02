From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH 1/7] typec: tcpm: Add PD Rev 3.0 definitions to PD
 header
Date: Thu, 2 Nov 2017 13:38:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1AAD4E@SW-EX-MBX01.diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <ae7217123a3421fd71d314a77a36bb42d8f6224d.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <20171101200830.GF12812@usblab-sd-06.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.166]:17785 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbdKBNiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 09:38:46 -0400
In-Reply-To: <20171101200830.GF12812@usblab-sd-06.qualcomm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jack Pham <jackp@codeaurora.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On 01 November 2017 20:09, Jack Pham wrote:

> Hi Adam,
>
> On Wed, Nov 01, 2017 at 05:03:09PM +0000, Adam Thomson wrote:
> > This commit adds definitions for PD Rev 3.0 messages, including
> > APDO PPS and extended message support for TCPM.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  include/linux/usb/pd.h | 162
> +++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 151 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index e00051c..77c6cd6 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
>
> <snip>
>
> >  #define PD_REV10	0x0
> >  #define PD_REV20	0x1
> > +#define PD_REV30	0x2
> >
> > +#define PD_HEADER_EXT_HDR	BIT(15)
> >  #define PD_HEADER_CNT_SHIFT	12
> >  #define PD_HEADER_CNT_MASK	0x7
> >  #define PD_HEADER_ID_SHIFT	9
> > @@ -59,18 +91,19 @@ enum pd_data_msg_type {
> >  #define PD_HEADER_REV_MASK	0x3
> >  #define PD_HEADER_DATA_ROLE	BIT(5)
> >  #define PD_HEADER_TYPE_SHIFT	0
> > -#define PD_HEADER_TYPE_MASK	0xf
> > +#define PD_HEADER_TYPE_MASK	0x1f
> >
> > -#define PD_HEADER(type, pwr, data, id, cnt)				\
> > +#define PD_HEADER(type, pwr, data, id, cnt, ext_hdr)			\
> >  	((((type) & PD_HEADER_TYPE_MASK) << PD_HEADER_TYPE_SHIFT) |	\
> >  	 ((pwr) == TYPEC_SOURCE ? PD_HEADER_PWR_ROLE : 0) |		\
> >  	 ((data) == TYPEC_HOST ? PD_HEADER_DATA_ROLE : 0) |		\
> > -	 (PD_REV20 << PD_HEADER_REV_SHIFT) |				\
> > +	 (PD_REV30 << PD_HEADER_REV_SHIFT) |				\
>
> You are making a hardcoded change for the Spec Rev field of every
> outgoing message to be 3.0. However, this needs to be flexible in order
> to support backwards compatibility when communicating with a 2.0 peer.
> The revision "negotiation" would need to be done at the time the first
> Request is sent such that both source & sink settle on the highest
> supported revision of both. (PD 3.0 spec section 6.2.1.1.5)

Thanks for the prompt comments. Much appreciated.

This is a fair point. The existing code was hard coded to Rev 2.0 but this
should really be based on capabilities of both sides, if we're truly following
the spec. Will take a look at this and try to address the problem.

>
> >  	 (((id) & PD_HEADER_ID_MASK) << PD_HEADER_ID_SHIFT) |		\
> > -	 (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT))
> > +	 (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT) |	\
> > +	 ((ext_hdr) ? PD_HEADER_EXT_HDR : 0))
> >
> >  #define PD_HEADER_LE(type, pwr, data, id, cnt) \
> > -	cpu_to_le16(PD_HEADER((type), (pwr), (data), (id), (cnt)))
> > +	cpu_to_le16(PD_HEADER((type), (pwr), (data), (id), (cnt), (0)))
> >
> >  static inline unsigned int pd_header_cnt(u16 header)
> >  {
> > @@ -102,16 +135,66 @@ static inline unsigned int pd_header_msgid_le(__le16
> header)
> >  	return pd_header_msgid(le16_to_cpu(header));
> >  }
> >
> > +#define PD_EXT_HDR_CHUNKED		BIT(15)
> > +#define PD_EXT_HDR_CHUNK_NUM_SHIFT	11
> > +#define PD_EXT_HDR_CHUNK_NUM_MASK	0xf
> > +#define PD_EXT_HDR_REQ_CHUNK		BIT(10)
> > +#define PD_EXT_HDR_DATA_SIZE_SHIFT	0
> > +#define PD_EXT_HDR_DATA_SIZE_MASK	0x1ff
> > +
> > +#define PD_EXT_HDR(data_size, req_chunk, chunk_num, chunked)
> 		\
> > +	((((data_size) & PD_EXT_HDR_DATA_SIZE_MASK) <<
> PD_EXT_HDR_DATA_SIZE_SHIFT) |	\
> > +	 ((req_chunk) ? PD_EXT_HDR_REQ_CHUNK : 0) |
> 	\
> > +	 (((chunk_num) & PD_EXT_HDR_CHUNK_NUM_MASK) <<
> PD_EXT_HDR_CHUNK_NUM_SHIFT) |	\
> > +	 ((chunked) ? PD_EXT_HDR_CHUNKED : 0))
> > +
> > +#define PD_EXT_HDR_LE(data_size, req_chunk, chunk_num, chunked) \
> > +	cpu_to_le16(PD_EXT_HDR((data_size), (req_chunk), (chunk_num),
> (chunked)))
> > +
> > +static inline unsigned int pd_ext_header_chunk_num(u16 ext_header)
> > +{
> > +	return (ext_header >> PD_EXT_HDR_CHUNK_NUM_SHIFT) &
> > +		PD_EXT_HDR_CHUNK_NUM_MASK;
> > +}
> > +
> > +static inline unsigned int pd_ext_header_data_size(u16 ext_header)
> > +{
> > +	return (ext_header >> PD_EXT_HDR_DATA_SIZE_SHIFT) &
> > +		PD_EXT_HDR_DATA_SIZE_MASK;
> > +}
> > +
> > +static inline unsigned int pd_ext_header_data_size_le(__le16 ext_header)
> > +{
> > +	return pd_ext_header_data_size(le16_to_cpu(ext_header));
> > +}
> > +
> >  #define PD_MAX_PAYLOAD		7
> > +#define PD_EXT_MAX_LEGACY_DATA	26
> > +#define PD_EXT_MAX_CHUNK_DATA	26
> > +#define PD_EXT_MAX_DATA		260
> >
> >  /**
> > - * struct pd_message - PD message as seen on wire
> > - * @header:	PD message header
> > - * @payload:	PD message payload
> > - */
> > +  * struct pd_ext_message_data - PD extended message data as seen on wire
> > +  * @header:    PD extended message header
> > +  * @data:      PD extended message data
> > +  */
> > +struct pd_ext_message_data {
> > +	__le16 header;
> > +	u8 data[PD_EXT_MAX_DATA];
> > +} __packed;
> > +
> > +/**
> > +  * struct pd_message - PD message as seen on wire
> > +  * @header:    PD message header
> > +  * @payload:   PD message payload
> > +  * @ext_msg:   PD message extended message data
> > +  */
> >  struct pd_message {
> >  	__le16 header;
> > -	__le32 payload[PD_MAX_PAYLOAD];
> > +	union {
> > +		__le32 payload[PD_MAX_PAYLOAD];
> > +		struct pd_ext_message_data ext_msg;
> > +	};
> >  } __packed;
>
> It seems that this structure just got ~9-10x fatter (28 byte payload ->
> 262 bytes). Just wondering if this has a noticeable impact on
> (performance, memory) considering the various places in TCPM where
> struct pd_message is stack-allocated? And for RX, we have more to
> malloc/memcpy in tcpm_pd_receive().

In my testing I've not noticed any problems as a result of this, but of course
we are dealing with larger data to support PD 3.0 extended messages so there
will be overhead. I'll take another and see if there are ways we can help to
reduce the impact. One possibility for now would be to keep the message size as
before as right now we don't have and PD3.0 controllers capable of unchunked
extended messages, at least not in the kernel, and this patch set doesn't allow
for unchunked messaging anyway.
