From: chenyu5 <yu.c.chen@intel.com>
Subject: Re: [RFC PATCH] tools/power turbostat: fix parameter passing for
 forked command
Date: Fri, 24 Jul 2015 14:02:34 +0800
Message-ID: <55B1D4FA.7050406@intel.com>
References: <1436580141-26507-1-git-send-email-yu.c.chen@intel.com> <CAJvTdK=2bN7eYLLNrFZh7tMbiHgCjNenvf8ggSDRKhOK7XAQNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49725 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbbGXF73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 01:59:29 -0400
In-Reply-To: <CAJvTdK=2bN7eYLLNrFZh7tMbiHgCjNenvf8ggSDRKhOK7XAQNA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 09:18, Len Brown wrote:
> Thanks for reporting this, Yu.
>
> Does this pre-pending a '+' to getopt_long's optstring to prevent it
> from permuting the arguments help?:
>
>
> -       while ((opt =3D getopt_long_only(argc, argv, "C:c:Ddhi:JM:m:P=
pST:v",
>
> +       while ((opt =3D getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:=
PpST:v",
>
Hi, Len,
this patch works, and because I did not see this patch in linux-pm
  branch or bleeding-edge branch, so I re-post this patch titled with
'v2' , is it suitable? thanks.

Yu
>
>
> Len Brown, Intel Open Source Technology Center
>

