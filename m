From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST] for Rafael's Linux-PM / For-Next
Date: Fri, 27 Oct 2017 00:32:36 +0000
Message-ID: <20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
References: <CGME20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62749 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbdJ0Acr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2017 20:32:47 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171027003245epoutp017a571aa72299bf48d5c4bbf9aac2510e~xRgt_1tNQ0358503585epoutp01H
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2017 00:32:45 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

Dear Rafael,

Here goes a pull request from PM/devfreq mainly focussing on supporting OPP better.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pullreq_20171026

for you to fetch changes up to aa7c352f9841ab3fee5bf1de127a45e6310124a6:

  PM / devfreq: Define the constant governor name (2017-10-26 17:08:40 +0900)

- ----------------------------------------------------------------
Pull Request from PM/devfreq to Linux-PM

- ----------------------------------------------------------------
Chanwoo Choi (7):
      PM / devfreq: Set min/max_freq when adding the devfreq device
      Revert "PM / devfreq: Add show_one macro to delete the duplicate code"
      PM / devfreq: Use the available min/max frequency
      PM / devfreq: Change return type of devfreq_set_freq_table()
      PM / devfreq: Show the all available frequencies
      PM / devfreq: Remove unneeded conditional statement
      PM / devfreq: Define the constant governor name

 drivers/devfreq/devfreq.c                 | 139 +++++++++++++++++++++---------
 drivers/devfreq/exynos-bus.c              |   5 +-
 drivers/devfreq/governor_passive.c        |   2 +-
 drivers/devfreq/governor_performance.c    |   2 +-
 drivers/devfreq/governor_powersave.c      |   2 +-
 drivers/devfreq/governor_simpleondemand.c |   2 +-
 drivers/devfreq/governor_userspace.c      |   2 +-
 drivers/devfreq/rk3399_dmc.c              |   2 +-
 include/linux/devfreq.h                   |  16 +++-
 9 files changed, 123 insertions(+), 49 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZ8n08AAoJEBOhurvWBoCKCWUP+wcU5R/IxENbUf/pM5wykU3x
PCr67nJSa4Iohg22BzmJo0MkXC7AoNwajc/rPgYlrnHwd1arPcDKjF/Mi8+0cJNS
hRuqKW3w67+rbiBnYvhHeLT2U1Ik0CQPEICeNM/pn0yDUVMPIEQUpBS2W3ghx8OG
3sufqxqsyMESnYmHluJAE9G3cFhxPipMNkd+cSA/xzqQxGO0ALsXAdSc/XJv9zVE
beiNIKz137XyddHA2Rwbcs9EL6swf6oDj6qPvXjsPPncG+pxoXydMmvjY5veMgW2
Hc49iTXLk2/srKIfhkpTyVHN4Y0MeDHJRwNaUm4i6OpWlZWR5J5tBw0mQYFLa81p
X9K5mtu6YllVu2MV+hEe6sqgDVVEnii1tQJ5uNDrT028/24Pe84LQGZvqNwBn2wP
APqvDQjCZObw0CS/RqVSKUvAmOS3+HmYJJEwaBmhK1j+ga4iFg1/MIDsFfuVEZIC
fhTw4TMbhsBHKqT1uRoHfS55q+hGXIMqtd1ZgvY/Cu/gX7h8ZKeW5ehVaJ/WA6iP
wLAf3WQHWgClDbe9mIU4nMQVrcp4DV3abQvbIzHzHOLN2HVwOgF2aX6wci95Iz1L
gWt6iP2ZhMqX19erIUp9W7B2WSGMto/vAA7Lhrm/w3nFl54f3r8wLoREBifjrRs/
2gBILsa/5o/eZOjcbayI
=J1Ix
-----END PGP SIGNATURE-----
