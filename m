From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] PM / devfreq: tegra: Update governor to use
 devfreq_update_stats()
Date: Wed, 19 Aug 2015 18:48:23 +0100
Message-ID: <20150819174823.GB22033@e104805>
References: <874354786.192611439873691246.JavaMail.weblogic@ep2mlwas01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <874354786.192611439873691246.JavaMail.weblogic@ep2mlwas01a>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org" <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 18, 2015 at 05:54:51AM +0100, MyungJoo Ham wrote:
> 
> Direct invocation of get_dev_status() is no more recommended.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Looks good to me as well.  You can add my

Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>

Cheers,
Javi
