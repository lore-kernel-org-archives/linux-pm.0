From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference leak
Date: Tue, 2 Apr 2019 12:43:14 +0200
Message-ID: <efe8fb3a-eb4a-a50a-c53a-0879a912fbd8@web.de>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

> The call to of_get_cpu_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.

I would prefer a wording like the following.

A reference counter was incremented for a CPU node by a call of
the function =E2=80=9Cof_get_cpu_node=E2=80=9D.
Thus decrement it after the last usage.


> Detected by coccinelle with the following warnings:

I wonder about the shown duplicate notification.
Can a single message be sufficient for the code search result
in this source file?

Regards,
Markus
