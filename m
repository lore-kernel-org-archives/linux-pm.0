From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug documentation
Date: Fri, 12 Aug 2016 13:53:58 +0200
Message-ID: <CAJZ5v0jo3r+XFCkh1oH726bwu0CfMnq7xr-seT1Cq_0r6BcTFg@mail.gmail.com>
References: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com>
 <20160812062241.GB30992@amd> <36DF59CE26D8EE47B0655C516E9CE64028786F22@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36127 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbcHLLyA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 07:54:00 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64028786F22@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Aug 12, 2016 at 1:46 PM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> Hi Pavel,
>
>> -----Original Message-----
>> From: Pavel Machek [mailto:pavel@ucw.cz]
>> Sent: Friday, August 12, 2016 2:23 PM
>> To: Chen, Yu C
>> Cc: Linux PM List; Rafael J. Wysocki; Len Brown; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug
>> documentation
>>
>> Hi!
>>
>> > Update the description of test_resume mode for hibernation.
>> >
>> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> > ---
>> >  Documentation/power/basic-pm-debugging.txt | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>>
>> That's certainly step in the right direction, but I guess it should be mentioned in
>> the other places, too. Something like this?
>>
>> Additionally, we have testproc. Should we move it to test_proc for consistency
>> (or replace test_resume with simple "resume"? That's what it does... it is
>> hibernate+resume...
> It looks like testproc has been removed in
> commit 48580ab8729865c81e148d59159fbe2aa7865511,

Yes, it was removed, back in 2011.

> so I think we can replace 'testproc/test' with 'resume' in interface.txt and add some description in it,
> I'll do that, thanks.

You mean "test_resume" I suppose?

Clearly, the documentation needs to be updated.

Let me take care of that later today.

Thanks,
Rafael
