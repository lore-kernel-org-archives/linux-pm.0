From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC] PM / Hibernate: no kernel_power_off when pm_power_off NULL
Date: Tue, 15 Apr 2014 11:34:52 -0700
Message-ID: <CADHgK6sCmPVZ--eyEnqnjfs_4C_PfHTgAUQ_Nb4oJP0mBDnQUw@mail.gmail.com>
References: <1395348795-8554-1-git-send-email-sebastian.capella@linaro.org>
	<1395348795-8554-2-git-send-email-sebastian.capella@linaro.org>
	<20140320212336.GA17368@amd.pavel.ucw.cz>
	<20140320213502.795a5d3c@alan.etchedpixels.co.uk>
	<CADHgK6uXg0CXZC5s5Z5Kpy6dYH58UChL-p9ozCCcoUU=-0KJYw@mail.gmail.com>
	<CADHgK6sh6TUc4jBQFQHTQuhze9=r2FBzF6aULUc_c+bbWYjp5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADHgK6sh6TUc4jBQFQHTQuhze9=r2FBzF6aULUc_c+bbWYjp5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Ping..

There appears to be disagreement on the correct path to take on this.

Pavel and Alan recommend that arm's machine_power_off shall never return

Russell suggests hibernation be modified to handle machine_power_off
returning; that x86 architecture (and others as well) can have
machine_power_off returning.

Discussions available at the links below:
https://lkml.org/lkml/2014/3/25/554  -- linux-arm discussion
https://lkml.org/lkml/2014/3/20/649  -- linux-pm discussion

Should I continue with the original hibernation patch from the
linux-pm discussion?

Does anyone have any response to Russel's commentsl?

Thanks!

Sebastian
