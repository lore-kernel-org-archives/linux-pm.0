From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/4] cpufreq: governor: Implement per policy instances
 of governors
Date: Fri, 22 Mar 2013 07:50:54 +0530
Message-ID: <CAKohpomDK+FQvhZsy672P+Q4U1s2AGtJ2QizFTaNqjMRh19G0g@mail.gmail.com>
References: <cover.1362381470.git.viresh.kumar@linaro.org>
	<0823a96fea2d8284b7d83cee390dd5973fdaaa94.1362381470.git.viresh.kumar@linaro.org>
	<CAKohponTZ29BX6CrUvFMy9RXV==0wRFu4C-W1xd6t1RmLASTvQ@mail.gmail.com>
	<2565053.YP0dCLmaW9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2565053.YP0dCLmaW9@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 22 March 2013 05:14, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, March 20, 2013 10:59:13 AM Viresh Kumar wrote:

>> I have queued all patches i had for 3.10 here:
>>
>> http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-3.10
>
> OK, applied these to linux-pm.git/bleeding-edge.

Thanks.

> At the moment bleeding-edge and linux-next diverged slightly on cpufreq, but
> I hope the bleeding-edge material won't cause build problems to occur, so I'll
> be able to move it to linux-next shortly.

There shouldn't be any build problems not because i have done all build testing
properly BUT because my tree is under continuously surveillance by Fengguang's
bot. And any problem with my branches is reported very early :)

>> commit f02fca9a2478088c4f7dadf82d998ae007a56285
>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>> Date:   Wed Mar 20 10:50:33 2013 +0530
>>
>>     fixup! cpufreq: governor: Implement per policy instances of governors
>
> I'd actually prefer you to post complete updated patches instead of these
> fixups.  They are real PITA for me and probably for everybody else trying
> to follow the cpufreq development recently.

Hmm... I always thought fixups are way easy to review (and i still
believe that's
true) as they just contain what got changed and so people don't have to review
whole patch again. BUT people who are looking for complete patches to apply
would be annoyed by this and hence i always show them path of my repo
where they can find it. So, what i may do is, post fixups and then resend
patches. So that reviewer knows what changed and others can have complete
patches too.

--
viresh
