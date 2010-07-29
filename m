From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Stable inclusion request - NVS changes from
	Matthew
Date: Thu, 29 Jul 2010 15:04:31 -0700
Message-ID: <20100729220431.GI17470__44297.8694955402$1280442933$gmane$org@kroah.com>
References: <201006291128.44099.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006291128.44099.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 29, 2010 at 11:28:43AM +0200, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> Please include
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd4c4f17d722ffeb2515bf781400675a30fcead7
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a6b69765ad794389f2fc3e14a0afa1a995221c2
> 
> (in this order) into the next 2.6.34.y release (and possibly older maintained
> -stable kernels where they apply).
> 
> The first one requires a little fixup in kernel/power/Makefile , but apart from
> this they apply to 2.6.34 just fine.

Now queued up.

thanks,

greg k-h
