From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 01/35] cpufreq: Implement light weight ->target_index()
 routine
Date: Mon, 19 Aug 2013 11:49:44 +0530
Message-ID: <CAKohpo=HvR9_6DvhhPV0JcBnkmF5bc0pbCQrF7sk=FKOayhcRA@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <eb988fc9e72b90b7ba99f16405f5dcb072da7840.1376392602.git.viresh.kumar@linaro.org>
 <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
 <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
 <CADGdYn4LoFEfZTd2bT=iGKRb5M=7CfpG-suxf3L-V5HXH7QuPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADGdYn4LoFEfZTd2bT=iGKRb5M=7CfpG-suxf3L-V5HXH7QuPQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, sparclinux@vger.kernel.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jesper Nilsson <jesper.nilsson@axis.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Steven Miao <realmz6@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LAK <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>, Mikael Starvik <starvik@axis.com>, Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.or>
List-Id: linux-pm@vger.kernel.org

On 19 August 2013 11:46, amit daniel kachhap <amit.daniel@samsung.com> wrote:
> I meant that something like 2 policies can be registered SCALE_DIRECT/STEPS.
> if SCALE_DIRECT is registered than target will be called with exact
> frequency. SCALE_STEPS will behave as currently happening. This way
> target_index api may not be needed. But looks like Rafael and others
> are fine with your approach so you can ignore this :)


 Why wouldn't we need target_index in case of SCALE_DIRECT? All
target_index is doing now is changing platform specific registers to configure
an exact frequency reported by index..
