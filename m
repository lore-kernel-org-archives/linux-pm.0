From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce
	acpi_pci_osc_control_query()
Date: Tue, 3 Aug 2010 11:27:11 +0200
Message-ID: <201008031127.12117.rjw__11608.9028575972$1280828022$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022353.04353.rjw@sisk.pl>
	<4C57A346.6020003@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C57A346.6020003@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Kenji Kaneshige wrote:
> (2010/08/03 6:53), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki<rjw@sisk.pl>
> 
> <snip.>
> 
> > +	mutex_lock(&osc_lock);
> > +	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> > +	mutex_unlock(&osc_lock);
> > +
> 
> One more comment here.
> 
> I think we can skip acpi_pci_query_osc() if all of queried controls are
> already granted to OS. Please see below
> 
> 	mutex_lock(&osc_lock);
> 	if ((root->osc_control_set & *ctrl_mask) == *ctrl_mask) {
> 		*ctrl_mask = root->osc_control_set;
> 		goto out;
> 	}
> 	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> 	mutex_unlock(&osc_lock);
> out:

Well I guess you mean:

 	mutex_lock(&osc_lock);
 	if ((root->osc_control_set & *ctrl_mask) != *ctrl_mask) 
 		status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
 	mutex_unlock(&osc_lock);

Otherwise we would return with the mutex held. :-)

Thanks,
Rafael
