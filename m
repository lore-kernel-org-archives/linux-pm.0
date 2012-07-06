From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle : move tlb flag to the cpuidle
	header
Date: Fri, 6 Jul 2012 23:29:51 +0200
Message-ID: <201207062329.51892.rjw@sisk.pl>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
	<201207052243.15048.rjw@sisk.pl> <4FF6C6E0.8020609@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF6C6E0.8020609@linaro.org>
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

On Friday, July 06, 2012, Daniel Lezcano wrote:
> On 07/05/2012 10:43 PM, Rafael J. Wysocki wrote:
> > On Thursday, July 05, 2012, Daniel Lezcano wrote:
> >> Move this specific flag to the header file.
> > 
> > The patch evidently does more than that.
> > 
> > Is it just a cleanup, or is there a functional reason for doing it?
> 
> It is just a cleanup.

In that case, can you please say that in the changelog?  I have no objections
to the patch itself, but the changelog is clearly substandard.

> Thanks for reviewing the patches.

No problem.

Thanks,
Rafael
