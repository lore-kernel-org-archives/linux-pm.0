From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Wed, 28 Sep 2016 21:26:42 -0500
Message-ID: <8a5f37bb-4870-b89e-6287-fcb43b2e708f@lwfinger.net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan>
 <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan>
 <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <20160927145114.GM14311@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34958 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbcI2C0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 22:26:44 -0400
In-Reply-To: <20160927145114.GM14311@csclub.uwaterloo.ca>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 09/27/2016 09:51 AM, Lennart Sorensen wrote:
> On Mon, Sep 26, 2016 at 04:28:29PM -0500, Larry Finger wrote:
>> Mostly I use a KDE applet named "System load" and look at the "average
>> clock", but the same info is also available in /proc/cpuinfo as "cpu MHz".
>> When the bug triggers, the system gets very slow, and the cpu fan stops even
>> though the cpu is still busy.
>>
>> Commit f7816ad, which had run for 7 days without showing the bug, failed
>> after about 2 hours today. All my testing since Sept. 9 has been wasted. Oh
>> well, that's the way it goes!
>
> Is it possible there is no bug and instead you have a hardware problem?
>
> What I am thinking:
>
> CPU fan stops, then CPU gets busy, CPU overheats, thermal throtling
> kicks in to protect CPU and it gets VERY slow.
>
> So maybe you have a bad CPU fan that is getting stuck.  Perhaps even if
> you have a motherboard that varies the CPU fan depending on need and the
> fan doesn't like the lowest speed and sometimes gets stuck when asked
> to go slow.
>
> Of course if the CPU fan is the problem that could explain why it takes
> varying amounts of time to see the problem.
>
> I suggest checking what the cpu temperature sensors are showing next
> time it gets slow.

By the time it gets slow, the CPU's cool, and one cannot see the temp just 
before that event happened.

The reason I suspect a bug is that it fails with 4.8-rcX, but not with 4.7. Of 
course, it could be something subtle that slightly changes the heat load, which 
causes the CPU temp to be a little higher so that the effect is triggered.

I am reasonably confident that it is not a hardware problem, but we may have to 
wait until 4.8 is released and gets wider usage. If no one else reports a 
problem, then I am certainly wrong.

Larry




