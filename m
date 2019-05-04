From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 13/18] hwmon/coretemp: Support multi-die/package
Date: Fri, 3 May 2019 22:58:23 -0400
Message-ID: <CAJvTdKk8n3EVZ2WKZHsUvyyvw1cF1tD4GPjqqGxueFbCvAsZ5A@mail.gmail.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
 <10af238e4f996ccfc0ecf8baedca04df0c65c7c1.1556657368.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10af238e4f996ccfc0ecf8baedca04df0c65c7c1.1556657368.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: X86 ML <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 1, 2019 at 12:24 AM Len Brown <lenb@kernel.org> wrote:
>
> From: Zhang Rui <rui.zhang@intel.com>

> @@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
>  static int __init coretemp_init(void)
>  {
>         int err;
> +       struct cpuinfo_x86 *c = &cpu_data(0);
>
>         /*
>          * CPUID.06H.EAX[0] indicates whether the CPU has thermal

FYI, the hunk above was errantly left over from v2 and included in this e-mail.

It is removed in git.
And that is the only difference between this e-mailed series and my
latest git tree.

thanks,
-Len
