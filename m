From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Mon, 24 Feb 2014 12:13:24 +0530
Message-ID: <CAKohpok3Y9H96rSFkUL=v3pMwRd9=YyVDfuY7SSSq6FevF1Snw@mail.gmail.com>
References: <cover.1392273722.git.viresh.kumar@linaro.org>
	<52FE71BD.3020103@wwwdotorg.org>
	<2869027.iYHxWOSS2C@vostro.rjw.lan>
	<52FEAECA.5080905@wwwdotorg.org>
	<CAKohpomhvuQQ0JN3wgLBnrSpFUjC9J9QwWZpD9nA6AFYw+paKA@mail.gmail.com>
	<5303C018.1020707@wwwdotorg.org>
	<CAKohponF7ag-tfv77JK0pDVukS6v3QeSY+G_br3FJGskMDCvVw@mail.gmail.com>
	<5304E93C.9000104@wwwdotorg.org>
	<90EA67AE-7F57-4F43-8967-642903AD72AC@linaro.org>
	<BEC64F5C-76E8-40C3-81BE-59096C3838F3@linaro.org>
	<53063E01.5030808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53063E01.5030808@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Kgene Kim <kgene.kim@samsung.com>, "jinchoi@broadcom.com" <jinchoi@broadcom.com>, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 20 February 2014 23:10, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Well, except that still leaves a bunch of errors in the kernel log, and
> I have to remember to ignore them:-/

Just for few releases, before this patchset goes in.

> It'd be nice if the cpufreq core didn't keep changing its behaviour and
> adding new error prints. It really should be up to the cpufreq drivers
> to log the errors if they experience any.

Hmm... not sure.. Its better to do error prints at a single place, i.e. cpufreq
core on behalf of all drivers. If there is a error being returned from some
routine, we better print a message for that. Rather than living in the illusion
that everything is fine :)
