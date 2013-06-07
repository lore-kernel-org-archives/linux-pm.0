From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL RESENT] CPUFreq: ARM Updates for v3.11
Date: Fri, 7 Jun 2013 16:39:49 +0530
Message-ID: <CAKohpokJt=8UpAKKEEFaojq-M_GPawrDRBdXL8erEDe2jh=Q4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-dev <linaro-dev@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-next

for you to fetch changes up to ea61623fe9badd5a195b3a0878e6d89a2f97ac0e:

  cpufreq: kirkwood: Select CPU_FREQ_TABLE option (2013-06-07 16:33:36 +0530)

----------------------------------------------------------------
Arnd Bergmann (2):
      cpufreq: SPEAr needs cpufreq table
      cpufreq: big.LITTLE needs cpufreq table

Ezequiel Garcia (1):
      cpufreq: kirkwood: Select CPU_FREQ_TABLE option

 drivers/cpufreq/Kconfig.arm | 3 +++
 1 file changed, 3 insertions(+)
