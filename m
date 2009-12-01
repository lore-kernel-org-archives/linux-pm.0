From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.32-rc8 - T500 fails to suspend to RAM
Date: Tue, 1 Dec 2009 22:46:58 +0100
Message-ID: <200912012246.58383.rjw__43592.4990139485$1259704106$gmane$org@sisk.pl>
References: <4B151FE2.3090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B151FE2.3090807@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lior Dotan <liodot@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 December 2009, Lior Dotan wrote:
> Hi,
> 
> Ever since I've upgraded to rc8, my T500 fails to suspend to RAM for the
> second time. Suspending for the first time works ok but when I resume and
> later try to suspend again the screen gets blank and the moon LED blinks
> forever. rc6 & rc7 as well as 2.6.31 worked great with out a problem.

Well, I don't see any particular change that might cause the symptoms you
describe between -rc7 and -rc8.  If this is 100% reproducible, I guess
bisecting is the only option at the moment.

Thanks,
Rafael
