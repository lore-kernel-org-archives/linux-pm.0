Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB14C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A083D217D4
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 17:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfDJRmA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:42:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:65290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfDJRlu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Apr 2019 13:41:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 10:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="160496169"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2019 10:41:49 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 10 Apr 2019 10:41:48 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.28]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.192]) with mapi id 14.03.0415.000;
 Wed, 10 Apr 2019 10:41:48 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     lkp <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [pm:bleeding-edge 47/52] drivers//acpi/acpi_configfs.c:112:32:
 error: 'ACPI_NAME_SIZE' undeclared; did you mean 'APR_NAME_SIZE'?
Thread-Topic: [pm:bleeding-edge 47/52] drivers//acpi/acpi_configfs.c:112:32:
 error: 'ACPI_NAME_SIZE' undeclared; did you mean 'APR_NAME_SIZE'?
Thread-Index: AQHU7rApcoRVXpyzdkiJAdVzXZlLmaY1q8Aw
Date:   Wed, 10 Apr 2019 17:41:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95830E0@ORSMSX110.amr.corp.intel.com>
References: <201904091650.n4PgwLCA%lkp@intel.com>
In-Reply-To: <201904091650.n4PgwLCA%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTI3N2VjNDEtZjFhOC00YTcwLWIwYWYtOWY0MjU2OWM5M2YwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV2ttRStkTGNUcEgrdVVcL1pNNXJyOHlSbHpuWEFOUmJKcUtGZnpnaDNjOXk4WlJ5VW1mQ0NLMk81M1hTdldrZWYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We renamed some of these:


Renamed some internal macros to improve code understanding and maintenance. The macros below all operate on single 4-character ACPI NameSegs, not generic strings (old -> new):
    ACPI_NAME_SIZE    -> ACPI_NAMESEG_SIZE
    ACPI_COMPARE_NAME -> ACPI_COMPARE_NAMESEG
    ACPI_MOVE_NAME    -> ACPI_COPY_NAMESEG



> -----Original Message-----
> From: lkp
> Sent: Tuesday, April 9, 2019 1:42 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: kbuild-all@01.org; linux-acpi@vger.kernel.org; devel@acpica.org;
> linux-pm@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Schmauss, Erik <erik.schmauss@intel.com>
> Subject: [pm:bleeding-edge 47/52] drivers//acpi/acpi_configfs.c:112:32:
> error: 'ACPI_NAME_SIZE' undeclared; did you mean 'APR_NAME_SIZE'?
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> pm.git bleeding-edge
> head:   ea3d77d1940b15ef51a4f4936d05e99fab4cecff
> commit: 756ae0e33ac30984626b5f570c21c2bd1defac4d [47/52] ACPICA: Rename
> nameseg length macro/define for clarity
> config: i386-randconfig-x001-201914 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 756ae0e33ac30984626b5f570c21c2bd1defac4d
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_signature_show':
> >> drivers//acpi/acpi_configfs.c:112:32: error: 'ACPI_NAME_SIZE'
> undeclared (first use in this function); did you mean 'APR_NAME_SIZE'?
>      return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->signature);
>                                    ^~~~~~~~~~~~~~
>                                    APR_NAME_SIZE
>    drivers//acpi/acpi_configfs.c:112:32: note: each undeclared
> identifier is reported only once for each function it appears in
>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_asl_compiler_id_show':
>    drivers//acpi/acpi_configfs.c:173:32: error: 'ACPI_NAME_SIZE'
> undeclared (first use in this function); did you mean 'APR_NAME_SIZE'?
>      return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->asl_compiler_id);
>                                    ^~~~~~~~~~~~~~
>                                    APR_NAME_SIZE
> >> drivers//acpi/acpi_configfs.c:174:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>     }
>     ^
>    drivers//acpi/acpi_configfs.c: In function
> 'acpi_table_signature_show':
>    drivers//acpi/acpi_configfs.c:113:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>     }
>     ^
> 
> vim +112 drivers//acpi/acpi_configfs.c
> 
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  104
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  105
> static ssize_t acpi_table_signature_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  106
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  107
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  108
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  109
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  110
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  111
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08 @112
> 	return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->signature);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  113
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  114
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  115
> static ssize_t acpi_table_length_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  116
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  117
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  118
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  119
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  120
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  121
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  122
> 	return sprintf(str, "%d\n", h->length);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  123
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  124
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  125
> static ssize_t acpi_table_revision_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  126
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  127
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  128
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  129
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  130
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  131
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  132
> 	return sprintf(str, "%d\n", h->revision);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  133
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  134
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  135
> static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char
> *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  136
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  137
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  138
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  139
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  140
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  141
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  142
> 	return sprintf(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  143
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  144
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  145
> static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg,
> char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  146
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  147
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  148
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  149
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  150
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  151
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  152
> 	return sprintf(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h-
> >oem_table_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  153
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  154
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  155
> static ssize_t acpi_table_oem_revision_show(struct config_item *cfg,
> char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  156
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  157
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  158
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  159
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  160
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  161
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  162
> 	return sprintf(str, "%d\n", h->oem_revision);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  163
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  164
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  165
> static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
> c62c15a9 drivers/acpi/acpi_configfs.c Andy Shevchenko  2019-03-11  166
> 					       char *str)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  167
> {
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  168
> 	struct acpi_table_header *h = get_header(cfg);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  169
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  170
> 	if (!h)
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  171
> 		return -EINVAL;
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  172
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  173
> 	return sprintf(str, "%.*s\n", ACPI_NAME_SIZE, h->asl_compiler_id);
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08 @174
> }
> 612bd01f drivers/acpi/configfs.c      Octavian Purdila 2016-07-08  175
> 
> :::::: The code at line 112 was first introduced by commit
> :::::: 612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35 ACPI: add support for
> loading SSDTs via configfs
> 
> :::::: TO: Octavian Purdila <octavian.purdila@intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
