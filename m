From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
 implement user_ops writer
Date: Thu, 01 Apr 2010 08:54:44 +1100
Message-ID: <4BB3C4A4.9080809@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>	<201003302303.12758.rjw@sisk.pl>
	<4BB2B3E5.7020708@crca.org.au>	<201003312225.25085.rjw@sisk.pl>
	<4BB3B95A.5000901@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB3B95A.5000901@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 01/04/10 08:06, Nigel Cunningham wrote:
>>>>> Wouldn't it also increase the memory requirements?
>>>>
>>>> Not really, or just a little bit (the size of the buffer).  I'm talking about
>>>> the image that's created atomically after we've frozen devices.
>>>
>>> The buffer would be the size of the compressed image.
>>
>> Not necessarily if the image is compressed in chunks.  According to
>> measurements I did some time ago, 256 KiB chunks were sufficient.
>
> I must be missing something. You're talking about doing compression of
> the image during the atomic copy, right? If that's the case, where do
> the 256KiB chunks come in?

Ah, we're talking about different things. I wasn't thinking about the 
size of buffers for compression, but instead where this compressed image 
would be stored (leading into the 1/6th extra below).

Regards,

Nigel
