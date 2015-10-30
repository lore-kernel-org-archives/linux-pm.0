From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] PM / OPP: opp-supported-hw and <prop>-name bindings
Date: Fri, 30 Oct 2015 06:55:04 +0530
Message-ID: <cover.1446167359.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36374 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053AbbJ3BZZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 21:25:25 -0400
Received: by pacfv9 with SMTP id fv9so59187149pac.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2015 18:25:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rob/Stephen/Rafael,

These bindings are discussed in detail earlier:
http://marc.info/?l=linux-kernel&m=144237804923159&w=2

and I was waiting for the multi-regulator series to get applied first,
to post these patches.

But that series is not moving at fast pace and probably its time to get
other things going at least.

These are already kind of approved by Rob and Stephen (these are the
bindings we came up with for solving the issues reported by Lee Jones),
but a formal Ack is still required to get them merged.

The first patch enables us to select only a subset of OPPs from the
bigger table, based on what version of the hardware we are running on.

The second one enables us to select slightly different values for
multiple properties, based on what kind of hardware they are running on.

And the last one removes an (unused) binding, which is replaced by the
second patch with a better solution.

@Stephen/Rob: I already have working code for these bindings, which I
shared with Lee earlier. Just that I need to rebase that without the
multi-regulator series, will do that in coming days. But please see if
we can get these Acked/merged before that :)

Viresh Kumar (3):
  PM / OPP: Add "opp-supported-hw" binding
  PM / OPP: Add
    {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
  PM / OPP: Remove 'operating-points-names' binding

 Documentation/devicetree/bindings/opp/opp.txt | 101 ++++++++++++++++++++------
 1 file changed, 79 insertions(+), 22 deletions(-)

-- 
2.6.2.198.g614a2ac

