From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v2 RFT 0/2] PM / Hibernate: sysfs resume
Date: Tue, 27 Aug 2013 18:13:55 -0700
Message-ID: <1377652437-2379-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50213 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab3H1BOM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2013 21:14:12 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so5536394pad.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2013 18:14:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@lists.infradead.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org

Patchset related to hibernation resume: one enhancement to make the use
of an existing file more general and one documentation update.

Both patches are based on the 3.11-rc6 tag.  This was tested on a
Pandaboard with partial hibernation support, and compiled on x86.

Further testing is needed on other platforms.  Please let me know if
you're able to verify this on any other systems.

[PATCH 1/2] PM / Hibernate: use name_to_dev_t to parse resume
  Use name_to_dev_t to parse the /sys/power/resume file making the
  syntax more flexible.  It supports the previous use syntax
  and additionally can support other formats such as
  /dev/devicenode and UUID= formats.

  By changing /sys/debug/resume to accept the same syntax as
  the resume=device parameter, we can parse the resume=device
  in the initrd init script and use the resume device directly
  from the kernel command line.

  kernel/power/hibernate.c |   18 +++++++++++++-----
  1 file changed, 13 insertions(+), 5 deletions(-)

[PATCH 2/2] PM / Hibernate: add section for resume options
  This adds a small section to the swsusp.txt file to address the
  options for resuming.  This comments on the manual resume
  option which is used when resorting to an initrd or initramfs
  for resuming.  Resuming from late init is discussed later in
  the document, but it seemed appropriate to list them together.

  Documentation/power/swsusp.txt |   15 ++++++++++++++-
  1 file changed, 14 insertions(+), 1 deletion(-)

Changes in v2:
--------------

* Added check for null return of kstrndup in hibernate.c


Thanks,

Sebastian

