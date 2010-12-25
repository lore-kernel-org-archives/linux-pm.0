From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 25 Dec 2010 22:50:52 +0100
Message-ID: <AANLkTikcTSgjdxR106H2XZdmepN40bTKfEgmP04OQAz3__44437.87353016$1293313899$gmane$org@mail.gmail.com>
References: <AANLkTi=aHU57xDq+-DWrN2sJsAwx_9bZ_ofy1rOmp0VH@mail.gmail.com>
	<Pine.LNX.4.44L0.1012251046060.5079-100000@netrider.rowland.org>
	<AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

Hi Ohad,

On Sat, Dec 25, 2010 at 9:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sat, Dec 25, 2010 at 6:21 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
>> Right. =A0You may or may not realize it, but this requirement means that
>> the driver _must_ bypass runtime PM sometimes.
>
> http://www.spinics.net/lists/linux-pm/msg22864.html
>
>> Now you've lost me. =A0Which of the driver's handlers are you talking
>> about?
>
> The driver's handler, which is called by mac80211, and is responsible
> to power off the device.
> The _same_ handler is being called either during runtime or during a
> system transition to suspend
>
>> What races?
>
> Driver thinks power is off and device is now fully reset, but it's isn't =
really

maybe it's worth starting off with the description of chip power
states and how they are mapped to runtime PM and static PM?

Most of the WLAN chips have some very low power modes, but you're
talking about _complete_ shutdown as a suspended state for both
runtime PM and static PM, is that correct?

Thanks,
   Vitaly
