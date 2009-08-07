From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/05] PM: Runtime PM v13 for Platform
	Devices 20090807
Date: Sat, 8 Aug 2009 00:42:31 +0900
Message-ID: <aec7e5c30908070842y19d01150yf6dd4279f8a674c1@mail.gmail.com>
References: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.44L0.0908071024370.2886-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908071024370.2886-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 7, 2009 at 11:32 PM, Alan Stern<stern@rowland.harvard.edu> wrot=
e:
> On Fri, 7 Aug 2009, Magnus Damm wrote:
>
>> PM: Runtime PM v13 for Platform Devices 20090807
>>
>> [PATCH 01/05] PM: Runtime PM v13 - add dev_pm_ops helpers
>
> This patch doesn't do anything much, besides reverting a change I asked
> Rafael to make. =A0I don't see how it helps platform-specific code do
> anything.

It's helping different bus types to implement the runtime part of the
dev_pm_ops in a consistent way. I suggest that all bus types should
return -ENOSYS if the callback is missing. And they can do so by using
the helper functions. The change is not platform specific, but my
latest SuperH platform Runtime PM prototype makes use of it.

The latest SuperH specific Runtime PM implementation require
dev_pm_ops even though there is no work to be done for the driver. The
code works in a sort of opt-in way at this point, so callbacks are
explicitly required. I'd like us to standardize on this behaviour if
possible, so runtime pm enabled platform drivers can be shared between
different platform bus implementations. So my LCDC platform driver
will work fine on both SuperH SoCs and ARM SoCs.

Sorry for reverting your change, but I couldn't see any clear benefit
with the v11->v13 lock-drop-inside-the-if-case change. Isn't it just
avoiding dropping the lock in the uncommon error case? Maybe I'm
misunderstanding.

>> [PATCH 02/05] PM: Runtime PM v13 - let bus-less devices succeed
>
> This could be added without 01/05. =A0But why do you want it? =A0Busless
> devices don't have PM runtime callbacks, so whether the core thinks the
> callbacks succeed or not doesn't make any difference.
>
> You say that "Runtime suspend and resume of devices on the platform bus
> is impossible without this change", but you don't explain why -- or why
> the patch makes runtime suspend and resume of these devices possible.

Right now, in the standard upstream kernel all platform devices get
assigned a parent device unless one exists are registration time. The
shared parent device is parent-less. Since the Runtime PM code resumes
the parent before the child, the resume operation will fail because
there is no dev_pm_ops for the shared parent.

So I wonder which way that is the best to allow resuming platform
devices. Patch [02/05] is one way, but maybe there are more elegant
ways to handle it? Should the platform code be modified instead? If
so, how? I suppose root hubs for USB may have a similar issue, no?

>> [PATCH 03/05] PM: Runtime PM v13 - add debug printouts
>
> This looks good.

Thanks. Maybe it's a good plan to add similar printouts to other
functions as well?

>> [PATCH 04/05] PM: Runtime PM v13 - CONFIG_PM_SLEEP=3Dn support
>
> This isn't needed at all; equivalent functionality is already present
> in v13 of Runtime PM.

Yep, I totally missed that one. Will drop.

>> [PATCH 05/05] PM: Runtime PM v13 - platform device bus support
>
> This doesn't affect the Runtime PM patch, so it shouldn't be rolled in
> with it. =A0They should remain separate.

Yeah, it should be kept separate. I still would like to hear an
ACK/NACK from someone if possible.

Thanks for your feedback!

/ magnus
