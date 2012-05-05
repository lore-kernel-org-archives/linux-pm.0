From: Adrian Fita <adrian.fita@gmail.com>
Subject: Re: [PATCH 1/1] battery: only refresh the sysfs files
 when pertinant information changes
Date: Sat, 05 May 2012 13:37:10 +0300
Message-ID: <4FA502D6.3000500@gmail.com>
References: <20120503124708.GA18622@srcf.ucam.org>
	<1336052907-15084-1-git-send-email-apw@canonical.com>
	<201205041529.07142.post@ralfj.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205041529.07142.post@ralfj.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Ralf Jung <post@ralfj.de>, Paolo Scarabelli <paolo@msw.it>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jonathan Nieder <jrnieder@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 04/05/12 16:29, Ralf Jung wrote:
> Hi,
> 
> I applied this to 3.4-rc5, and it fixes the issue. Thanks a lot :)

[...]

Hi. I got to test the patch today against the 3.2.16 stable kernel and I
can confirm that it solved the issue. I no longer see "remove"/"add"
events when running "udevadm monitor --property"; I only see "change"
events.

Thanks alot!

Do you know if this patch will be backported to the 3.2 kernel, which
will be the stable kernel for many linux distributions for many years (I
know that the next Debian Stable/wheezy will be using the 3.2 kernel)?

PS: you misspelled "pertinent" in the patch's title. You wrote "pertinant".

Regards,
-- 
Fita Adrian
