From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC][RFP] LPC2016 Thermal MC
Date: Mon, 2 May 2016 20:55:49 -0700
Message-ID: <20160503035548.GA19699@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
Cc: caesar.wang@rock-chips.com, wxt@rock-chips.com, j-keerthy@ti.com, punit.agrawal@arm.com, viresh.kumar@linaro.org, wni@nvidia.com, Srikar Srimath Tirumala <srikars@nvidia.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Linux-pm,

As a continuation of the work done in 2015, I am proposing this year a
micro conference (MC) to gather thermal interested parties to discuss
improvements to the thermal subsystem [1]. Last year, I believe it was a
success in terms of achieving the goal of creating awareness, however, I
believe we need to continue improving the design and architecture of the
subsystem by listening how engineers are using it in their use cases.

Clearly, more and more I hear engineers looking for a better solution
for userspace driven policies. For this reason, I am proposing the
following agenda:

  * Sensor API: 
    * Current sensor feature support: what is really in use. 
    * interaction with other subsystems: IIO and hwmon, path to consolidation
  * Userspace governors:
    * What is currently existing
    * What feature are controlled by userspace governors
  * Effective userspace notification mechanism
    * Existing mechanism for notification
    * GAPs in notification needed to be covered
    * Policy configuration and interaction with userspace 
  * Cooling devices
    * Userspace listeners for cooling device state transition
    * Userspace cooling devices

If you are interested and have a good use case description to be discussed
within to above topics, please add your name to the list in the wiki, and
sign up for driving one of the topics. It would be nice to conclude the
MC with a list of practical required changes in the subsystem, based on
real use case scenarios.

I know the MC has a time limitation and we can probably also progress by
discussing code in the mailing list. However, I also believe it is important
to have a face to face discussion to better understand the use cases that
are not covered today.

Also, if you believe another topic needs to be covered, please, do not
hesitate to add it to the list.

Note: If you believe I forgot to copy someone, please help me to
properly make sure the message reaches the right quorum.

BR,

Eduardo Valentin

[1] - http://wiki.linuxplumbersconf.org/2016:thermal#proposed_topics_tentative
