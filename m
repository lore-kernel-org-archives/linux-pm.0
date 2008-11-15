From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/1] Updated patch (was: Re: [PATCH -next]
	Hibernate: Take overlapping zones into account)
Date: Sat, 15 Nov 2008 02:01:33 +0100
Message-ID: <200811150201.34629.rjw__16284.2271537103$1226710817$gmane$org@sisk.pl>
References: <200811081356.13060.rjw@sisk.pl>
	<alpine.LFD.2.00.0811111300580.4480@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0811111300580.4480@localhost.localdomain>
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
To: Len Brown <lenb@kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Pavel Machek <pavel@suse.cz>, Andy Whitcroft <apw@shadowen.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

Please replace the "Hibernate: Take overlapping zones into account" patch
(commit 7bff0a928535512dc61cfc81c8ce5dd2a0e53f19 in the suspend branch) with
the new version in the following message.

The old version introduces a tiny memory leak in create_mem_extents().

Thanks,
Rafael
