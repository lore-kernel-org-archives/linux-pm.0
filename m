From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 6 (acpi: PM=n)
Date: Thu, 6 May 2010 08:05:38 -0700
Message-ID: <20100506080538.b566f50e.randy.dunlap__32217.6906899132$1273158815$gmane$org@oracle.com>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506151502.f97afe54.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010 15:15:02 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20100505:


When CONFIG_PM is not set:

drivers/built-in.o: In function `acpi_init':
bus.c:(.init.text+0x2d84): undefined reference to `pm_flags'
bus.c:(.init.text+0x2d91): undefined reference to `pm_flags'

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
