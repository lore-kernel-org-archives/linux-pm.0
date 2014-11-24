From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] thermal:core:fix: Check return code of the
 ->get_max_state() callback
Date: Mon, 24 Nov 2014 16:30:40 +0530
Message-ID: <CAKohpok3pTEk05L7t+o6BYoODnBboAegg1o9dAj8=VOk8G7odQ@mail.gmail.com>
References: <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
	<1416305790-27746-1-git-send-email-l.majewski@samsung.com>
	<20141121180826.GA3331@developer>
	<20141124113854.36975fb2@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141124113854.36975fb2@amdc2363>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 24 November 2014 at 16:08, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> As I look into the cpufreq-dt.c driver - in the cpufreq_init()
> function, the call to of_cpufreq_cooling_register() is performed just
> before cpufreq_table_validate_and_show().
> It looks like a mistake in the cpufreq-dt.c code.

Yes. Just fixed it up and sent a patch. Please provide your
tested-by's..
