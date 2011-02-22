From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCHv2] amba: support pm ops
Date: Tue, 22 Feb 2011 11:14:33 +0530
Message-ID: <AANLkTin75bnW69CDrKPkw+4K9sfAMLGPqYsV-UfHTASD__42726.6775783666$1298353653$gmane$org@mail.gmail.com>
References: <1297928986-31171-1-git-send-email-rabin.vincent@stericsson.com>
	<1298271737-1606-1-git-send-email-rabin.vincent@stericsson.com>
	<201102212126.10742.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102212126.10742.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 22, 2011 at 01:56, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, February 21, 2011, Rabin Vincent wrote:
>> Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
>> The implementation of AMBA bus pm ops is based on the platform bus
>> implementation.
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks.

> (although I'd probably avoid creating an empty struct dev_pm_ops object
> if both CONFIG_HIBERNATION and CONFIG_SUSPEND are unset).

Done in v3.
