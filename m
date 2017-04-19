From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Wed, 19 Apr 2017 09:52:48 +0200
Message-ID: <20170419075248.GD18887@pali>
References: <20170412230854.GA11963@fury>
 <3317007.TCiWpp4m4U@aspire.rjw.lan>
 <20170418163325.GC25405@fury>
 <201704182128.36169@pali>
 <20170418224931.GA21569@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34456 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760644AbdDSHww (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:52:52 -0400
Content-Disposition: inline
In-Reply-To: <20170418224931.GA21569@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday 18 April 2017 15:49:31 Darren Hart wrote:
> On Tue, Apr 18, 2017 at 09:28:36PM +0200, Pali Rohár wrote:
> > And still, if write audit filters for every one existing wmi driver in 
> > kernel, there still audit filter can say to userspace that current 
> > request cannot be accepted and sent to firmware.
> 
> For the vast majority of platforms, the WMI interface would not be exported, and
> we would not attempt to write audit filters. As a rule, I would expect this
> effort to be triggered by a request from the vendor, and done only with their
> explicit involvement after providing complete documentation of the WMI
> interface.

Ok, if WMI interface would be exported to userspace only after previous
communication with vendor, then this should be OK. It also means that we
need to maintain list of WMI GUIDs...

> However, we would expect those filters to deny as few calls as possible for the
> platforms that choose to export the WMI interface to userspace.

I expect that vendor would be communicate with kernel developers and
filters would be written with agreement with vendor. This seems OK.

> For example, dell-wmi.c would be largely unaffected as the EVENT_GUID is not
> interesting for userspace (per Mario) and would not be exported. The Descriptor
> GUID should be safe to share with userspace, at least for the way we use it in
> the kernel. Similar for dell-wmi-aio.c
> 
> For dell-wmi-led.c, we could most likely not export the GUID at all, but if we
> did, we could choose to filter on device_id or command from the bios_args used
> in the input buffer.
> 
> I don't think I've seen exactly what the WMI interface for the existing SMBIOS
> stuff will look like, but we seem to have a fairly structured way of accessing it
> today, which should allow us to filter out those specific usages (such as
> rfkill). Additionally, the concern that userspace can make use of the same
> mechanism as the kernel is where we are today with libsmbios.
> 
> With WMI filters, we could, for example, deny all DELL_SMBIOS_WMI GUID calls
> equivalent to "class 17, select 11" (Wireless control), since that is handled
> internally. Similarly for "4,11" (KBD ALS).
> 
> > 
> > This would mean that userspace application would not be able to do ANY 
> > WMI method call (as e.g. on windows) and so for some vendors it can be 
> > useless.
> 
> We address this with more granular filters.
> 
> > And here I'm not sure, how hard would be to write those audit filters 
> > for all wmi kernel drivers and if it would be possible without wmi 
> > documentation of those vendor apis (which we do not have).
> 
> As above, we won't write them for every wmi kernel driver. Only for those
> vendors which engage with us to do so.
> 
> > Potential vendors can decide based on above fact, that their userspace 
> > application rather rmmod wmi kernel driver for particular GUID (which 
> > release occupation of wmi device) and their userspace application starts 
> > working. And this is I think situation which is bad for kernel and we 
> > should prevent it.
> 
> I agree we would want to avoid this. As this is off by default and only enabled
> / implemented with the cooperation of the vendor in the first place, I suspect
> this kind of antagonistic interaction is unlikely.
> 
> You previously mentioned doing a vendor specific interface. This was my initial
> response as well, but it doesn't meet the intent of the WMI interface, nor the
> needs of vendors like Dell. That is, it requires a priori knowledge of all
> current and future interfaces, and/or the continued gating on the Linux kernel
> in order to allow a new method/interface. Further, by creating these interfaces,
> we become more tied to them, and they will grow over time, until they are a very
> large set of mostly deprecated interfaces which we can't remove for legacy
> reasons.

Benefit of vendor specific API is code de-duplication and having common
functions in one place. E.g. code for changing SMBIOS token does not
have to be implemented in both userspace and kernel, just in kernel.

Also handling generic API requests from userspace in kernel and then
pass them to firmware is a bit harder and less error prone. Also audit
filters would be less easier...

I still think that we do not have to export WMI as is to userspace and
personally I do not think it is the best solution even if Microsoft is
doing it...

But if we are unable to design such API and vendor (e.g. Dell) already
wants WMI API in userspace, then we probably should export it from them.

> All that said, I appreciate the concerns you've raised and they mirror many of
> my own. I don't think we can just say "no, Windows Management Instrumentation is
> only accessible in Linux within the kernel" as that is ultimately contrary to
> the purpose of the mechanism. With those concerns in mind, I proposed the
> general approach below which affords considerable freedom for vendors to manage
> their systems while retaining the right to deny access to the existing Linux
> kernel drivers. At the same time, it provides a general purpose interface to
> userspace which won't collect legacy code we have to maintain forever.

The main concern is that WMI is something like meta-API or RPC. In most
cases it would be needed to write "wrapper" code around to do call
needed functions or do something. It is needed to written in kernel
(e.g. for class drivers or for filters), but also vendor needs to
duplicate functionality in userspace. And this does not seems to be
ideal, probably it can be design-antipattern.

As wrote above, I'm fine with explicit whitelist of WMI GUIDs which will
be exported to userspace after communication with vendor.

One more thing: We should not provide new interface API/ABI between
kernel and userspace without some open source implementation of
userspace. This is IIRC some Linus's rule. And I'm not sure if vendors
are going to provide some userspace WMI implementations as open
source...

-- 
Pali Rohár
pali.rohar@gmail.com
