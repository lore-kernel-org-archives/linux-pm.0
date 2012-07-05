From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] cpuidle: move enter_dead to the driver
	structure
Date: Thu, 5 Jul 2012 22:40:57 +0200
Message-ID: <201207052240.57686.rjw@sisk.pl>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
	<1341494608-16591-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1341494608-16591-3-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 05, 2012, Daniel Lezcano wrote:
> The 'enter_dead' function is only used for processor_idle.c
> and the same function is used several times. We fall into the
> same abuse with the multiple callbacks for the same function.

This isn't abuse, mind you.  This is a normal practice.

> This patch fixes that by moving the 'enter_dead' function to the
> driver structure. A flag CPUIDLE_FLAG_DEAD_VALID has been added
> to handle the callback conditional invokation.

And how does that improve things?

Rafael
