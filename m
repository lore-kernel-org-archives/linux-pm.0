From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 0/3] suspend-utils KMS Full Support
Date: Mon, 11 Mar 2013 11:46:18 +0100
Message-ID: <1362998781-4651-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:49894 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab3CKKqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 06:46:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

These patches makes s2ram KMS support usable in command line and config
file. The first patch removes a issue with the option --no_kms, because
the option requires an argument, but this argument is not needed.

The second patch add support for no_mks option in the config file.

The third patch is only documentation, with the option table to reach a=
ll
possible cases to suspend to ram (user quirks, database and KMS).

These patches should be applied before the patches about UUID support.

Saludos,
kix

Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) (3):
  The flag "no_kms" doesn't need arguments
  Support to disable KMS using config file
  README: Documentation for s2ram options

 README       |   50 ++++++++++++++++++++++++++++++++++++++++++++------
 s2ram-main.c |    6 +++---
 s2ram-x86.h  |    2 +-
 s2ram.c      |   11 ++++++++++-
 4 files changed, 58 insertions(+), 11 deletions(-)

--=20
1.7.10.4

