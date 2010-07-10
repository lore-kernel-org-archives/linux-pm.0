From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pm: Add runtime PM statistics to sysfs
Date: Sat, 10 Jul 2010 09:29:42 -0700
Message-ID: <20100710092942.1fa1d80c__27542.1187318445$1278779198$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.1007091056510.1582-100000@iolanthe.rowland.org>
	<Pine.LNX.4.44L0.1007091106070.1582-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007091106070.1582-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 9 Jul 2010 11:11:06 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> This is because update_pm_runtime_accounting() doesn't take into 
> account the existence of the RPM_RESUMING and RPM_SUSPENDING states;
> it treats them all the same as RPM_ACTIVE.

this is by design fwiw; I'm considering the time spent going in and out
of suspend as "active", it's a little on the conservative side, but the
underlying assumption is that you're still burning power until you're
really suspended. Better to be conservative and not count it as really
suspended....


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
