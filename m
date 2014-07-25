From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/14] cpufreq: cpu0: Extend support beyond CPU0, V2
Date: Fri, 25 Jul 2014 20:04:17 +0530
Message-ID: <CAKohpomDGc9Y8yn0SuT9PYRQqx+0Ln10g9V-ZXd=itgXpGqP6g@mail.gmail.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<20140717093518.486ac244@free-electrons.com>
	<CAKohpokZXUzXKRWBje7QF_jrvOd5dmfmWQ2Csf3xiMuvT_vPYA@mail.gmail.com>
	<2399813.Puj1SZWhCh@vostro.rjw.lan>
	<CAKohpomKzK8pMJs1gv+uXxhd17HtCQyfjSnVYw9KpGz6FwbgDA@mail.gmail.com>
	<CAKohpo=HKUkGRK4NX7E59z5QthcKbZKETB-DuP10xj3x+vdHaQ@mail.gmail.com>
	<CAL_JsqKqCeU0zs+rS1vxsOeh=Kuw_-gaVHtGU76Lb6TchCTytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKqCeU0zs+rS1vxsOeh=Kuw_-gaVHtGU76Lb6TchCTytw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Thomas P Abraham <thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arvind Chauhan <arvind.chauhan-5wv7dgnIgG8@public.gmane.org>, Sachin Kamat <spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 25 July 2014 19:59, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> A temporary solution would have to be NOT in DT because once you add
> something into DT you are stuck with it for some time. You could

I agree..

> simply support independent clocks by looking at the platform type, but
> that is still risky since you may want to define the OPP in DT
> differently for the 2 cases.

Or because we are going to create platform devices for now, lets have
some platform data for cpufreq-cpu0 ?

> The other problem with temporary solutions is once they are accepted,
> people loose motivation to create the permanent solution. "Can you
> take this now and I'll fix the issues later" is a red flag to
> maintainers.

I completely agree, but there are few points here which might make the red
flag yellow if not green :)
- I co-maintain this framework and so I do care about it :)
- Even with the temporary stuff the solution wouldn't be complete for platforms
with multiple clusters having separate clock lines.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
