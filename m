From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: SRCU: add a static initializer and let cpufreq use it
Date: Fri, 25 May 2018 12:19:56 +0200
Message-ID: <20180525101958.13277-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de
List-Id: linux-pm@vger.kernel.org

cpufreq would benefit from a static initializer which avoids an initcall
and bug fixing in case the warning (notifier used before initialized)
has been triggered.

Sebastian
