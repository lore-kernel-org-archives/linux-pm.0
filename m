From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Suspend Problems
Date: Sun, 14 Jun 2009 14:12:53 +0200
Message-ID: <200906141412.54225.rjw@sisk.pl>
References: <f70484c50906131954s171ad307w297af4f503f1f837@mail.gmail.com>
	<200906141113.16311.rjw@sisk.pl>
	<f70484c50906140339i4dfd8d8aob67f7a1789fda58e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f70484c50906140339i4dfd8d8aob67f7a1789fda58e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Regivan Hugo Nunes Santiago <regivan@dimap.ufrn.br>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 14 June 2009, Regivan Hugo Nunes Santiago wrote:
> The Kernel was 2.6.22-15-generic.
> 
> Thank you again,
> Regivan
> 
> ps. Could you teach me, how will you find the description of my machine in
> the old kernel?

Well, that depends on what you mean by "the description". :-)

Can you please try the 2.6.30 kernel from kernel.org booting it with
acpi_sleep=s4_nohwsig in its command line?

Best,
Rafael
