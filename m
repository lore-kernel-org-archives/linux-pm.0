From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Bad rpath in cpupower with 4.0-rcX
Date: Fri, 6 Mar 2015 08:47:45 -0500
Message-ID: <20150306134745.GC4801@hansolo.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbbCFNtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Mar 2015 08:49:00 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "sriram@marirs.net.in" <sriram@marirs.net.in>, Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,

Commit 5c1de006e8e66 (cpupower Makefile change to help run the tool
without 'make install') added an rpath to the cpupower binary.  From
what I can understand, this is to make it easier to run cpupower from
the local build directory without having to run make install.  It does
accomplish that, but it also leaves the binary with the rpath in it
which is considered bad practice.  It also causes cpupower to fail in
rpmbuild with the following error:

ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './'
in [./]
error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
    Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)

I understand the want for eased development, but couldn't people just
set LD_LIBRARY_PATH instead?

josh
