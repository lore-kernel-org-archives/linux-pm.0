From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernate causes nobody cared on acpi irq
Date: Thu, 13 Aug 2009 22:46:25 +0200
Message-ID: <4A847BA1.9080805__20849.257350392$1250196520$gmane$org@gmail.com>
References: <4A833CAD.5050209@gmail.com> <200908130021.34378.rjw@sisk.pl>
	<4A846F04.9050005@gmail.com> <200908132220.01334.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908132220.01334.rjw@sisk.pl>
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
Cc: "Brown, Len" <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08/13/2009 10:20 PM, Rafael J. Wysocki wrote:
> Well, nothing obvious comes to mind.

Hmm, looks like a fresh qemu-kvm bug. noapic fixes that. I never needed
that, but even 2.6.30 doesn't work with it now. Or maybe something on
the host kernel broke recently. -ETOOMANYBUGS. Thanks.
