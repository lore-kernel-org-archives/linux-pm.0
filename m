From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: arm_big_little: add SCPI interface driver
Date: Fri, 01 May 2015 18:10:23 +0100
Message-ID: <1430500223.6009.12.camel@linaro.org>
References: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>
			 <1430134846-24320-5-git-send-email-sudeep.holla@arm.com>
		 <1430486378.3045.56.camel@linaro.org> <55438062.8050309@arm.com>
	 <1430489566.3045.64.camel@linaro.org> <55438A6C.50805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55438A6C.50805@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2015-05-01 at 15:15 +0100, Sudeep Holla wrote:
> No issues, it's better to have remainders like this :). I plan to post
> something in the next version.

Will that also include the other piece of the puzzle to get the
big.LITTLE cpufreq driver running? ;-)  ...
https://github.com/ARM-software/linux/commit/29c33a5865437f0745e8e3a9beb5f82694257b4d

With that, and device-tree updates [1], I've finally managed to get this
patch series running on Juno with v4.1-rc1 and they pass some basic
smoke testing.

-- 
Tixy
