From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/3] phy: core: Drop unused runtime PM APIs
Date: Sat, 23 Dec 2017 17:55:05 +0800
Message-ID: <201712231747.GRtgkilA%fengguang.wu@intel.com>
References: <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdLWJzb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 23 Dec 2017 04:55:31 -0500
Content-Disposition: inline
In-Reply-To: <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: kbuild-all@01.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ulf,

I love your patch! Yet something to improve:

[auto build test ERROR on phy/next]
[also build test ERROR on v4.15-rc4 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ulf-Hansson/phy-core-Re-work-runtime-PM-deployment-and-fix-an-issue/20171223-170432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: i386-randconfig-a0-201751 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers//ata/ahci.c: In function 'ahci_init_one':
>> drivers//ata/ahci.c:1761:2: error: implicit declaration of function 'pm_runtime_put_noidle' [-Werror=implicit-function-declaration]
     pm_runtime_put_noidle(&pdev->dev);
     ^
   drivers//ata/ahci.c: In function 'ahci_remove_one':
>> drivers//ata/ahci.c:1767:2: error: implicit declaration of function 'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
     pm_runtime_get_noresume(&pdev->dev);
     ^
   cc1: some warnings being treated as errors
--
   drivers//ata/libahci.c: In function 'ahci_rpm_get_port':
>> drivers//ata/libahci.c:239:2: error: implicit declaration of function 'pm_runtime_get_sync' [-Werror=implicit-function-declaration]
     return pm_runtime_get_sync(ap->dev);
     ^
   drivers//ata/libahci.c: In function 'ahci_rpm_put_port':
>> drivers//ata/libahci.c:251:2: error: implicit declaration of function 'pm_runtime_put' [-Werror=implicit-function-declaration]
     pm_runtime_put(ap->dev);
     ^
   cc1: some warnings being treated as errors
--
   drivers//ata/ahci_ceva.c: In function 'ceva_ahci_resume':
>> drivers//ata/ahci_ceva.c:326:2: error: implicit declaration of function 'pm_runtime_disable' [-Werror=implicit-function-declaration]
     pm_runtime_disable(dev);
     ^
>> drivers//ata/ahci_ceva.c:327:2: error: implicit declaration of function 'pm_runtime_set_active' [-Werror=implicit-function-declaration]
     pm_runtime_set_active(dev);
     ^
>> drivers//ata/ahci_ceva.c:328:2: error: implicit declaration of function 'pm_runtime_enable' [-Werror=implicit-function-declaration]
     pm_runtime_enable(dev);
     ^
   cc1: some warnings being treated as errors
--
   drivers//ata/ahci_qoriq.c: In function 'ahci_qoriq_resume':
>> drivers//ata/ahci_qoriq.c:306:2: error: implicit declaration of function 'pm_runtime_disable' [-Werror=implicit-function-declaration]
     pm_runtime_disable(dev);
     ^
>> drivers//ata/ahci_qoriq.c:307:2: error: implicit declaration of function 'pm_runtime_set_active' [-Werror=implicit-function-declaration]
     pm_runtime_set_active(dev);
     ^
>> drivers//ata/ahci_qoriq.c:308:2: error: implicit declaration of function 'pm_runtime_enable' [-Werror=implicit-function-declaration]
     pm_runtime_enable(dev);
     ^
   cc1: some warnings being treated as errors

vim +/pm_runtime_put_noidle +1761 drivers//ata/ahci.c

d243bed32f drivers/ata/ahci.c  Tirumalesh Chalamarla   2016-02-16  1642  
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1643  	/* save initial config */
394d6e535f drivers/ata/ahci.c  Anton Vorontsov         2010-03-03  1644  	ahci_pci_save_initial_config(pdev, hpriv);
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1645  
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1646  	/* prepare host */
453d3131ec drivers/ata/ahci.c  Robert Hancock          2010-01-26  1647  	if (hpriv->cap & HOST_CAP_NCQ) {
453d3131ec drivers/ata/ahci.c  Robert Hancock          2010-01-26  1648  		pi.flags |= ATA_FLAG_NCQ;
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1649  		/*
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1650  		 * Auto-activate optimization is supposed to be
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1651  		 * supported on all AHCI controllers indicating NCQ
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1652  		 * capability, but it seems to be broken on some
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1653  		 * chipsets including NVIDIAs.
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1654  		 */
83f2b9630c drivers/ata/ahci.c  Tejun Heo               2010-03-30  1655  		if (!(hpriv->flags & AHCI_HFLAG_NO_FPDMA_AA))
453d3131ec drivers/ata/ahci.c  Robert Hancock          2010-01-26  1656  			pi.flags |= ATA_FLAG_FPDMA_AA;
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1657  
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1658  		/*
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1659  		 * All AHCI controllers should be forward-compatible
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1660  		 * with the new auxiliary field. This code should be
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1661  		 * conditionalized if any buggy AHCI controllers are
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1662  		 * encountered.
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1663  		 */
40fb59e75a drivers/ata/ahci.c  Marc Carino             2013-08-24  1664  		pi.flags |= ATA_FLAG_FPDMA_AUX;
453d3131ec drivers/ata/ahci.c  Robert Hancock          2010-01-26  1665  	}
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1666  
7d50b60b5e drivers/ata/ahci.c  Tejun Heo               2007-09-23  1667  	if (hpriv->cap & HOST_CAP_PMP)
7d50b60b5e drivers/ata/ahci.c  Tejun Heo               2007-09-23  1668  		pi.flags |= ATA_FLAG_PMP;
7d50b60b5e drivers/ata/ahci.c  Tejun Heo               2007-09-23  1669  
0cbb0e774b drivers/ata/ahci.c  Anton Vorontsov         2010-03-03  1670  	ahci_set_em_messages(hpriv, &pi);
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1671  
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1672  	if (ahci_broken_system_poweroff(pdev)) {
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1673  		pi.flags |= ATA_FLAG_NO_POWEROFF_SPINDOWN;
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1674  		dev_info(&pdev->dev,
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1675  			"quirky BIOS, skipping spindown on poweroff\n");
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1676  	}
1fd684346d drivers/ata/ahci.c  Rafael J. Wysocki       2009-01-19  1677  
9b10ae86d1 drivers/ata/ahci.c  Tejun Heo               2009-05-30  1678  	if (ahci_broken_suspend(pdev)) {
9b10ae86d1 drivers/ata/ahci.c  Tejun Heo               2009-05-30  1679  		hpriv->flags |= AHCI_HFLAG_NO_SUSPEND;
a44fec1fce drivers/ata/ahci.c  Joe Perches             2011-04-15  1680  		dev_warn(&pdev->dev,
9b10ae86d1 drivers/ata/ahci.c  Tejun Heo               2009-05-30  1681  			 "BIOS update required for suspend/resume\n");
9b10ae86d1 drivers/ata/ahci.c  Tejun Heo               2009-05-30  1682  	}
9b10ae86d1 drivers/ata/ahci.c  Tejun Heo               2009-05-30  1683  
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1684  	if (ahci_broken_online(pdev)) {
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1685  		hpriv->flags |= AHCI_HFLAG_SRST_TOUT_IS_OFFLINE;
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1686  		dev_info(&pdev->dev,
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1687  			 "online status unreliable, applying workaround\n");
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1688  	}
5594639aab drivers/ata/ahci.c  Tejun Heo               2009-08-04  1689  
8bfd174312 drivers/ata/ahci.c  Sui Chen                2017-05-09  1690  
8bfd174312 drivers/ata/ahci.c  Sui Chen                2017-05-09  1691  	/* Acer SA5-271 workaround modifies private_data */
8bfd174312 drivers/ata/ahci.c  Sui Chen                2017-05-09  1692  	acer_sa5_271_workaround(hpriv, pdev);
8bfd174312 drivers/ata/ahci.c  Sui Chen                2017-05-09  1693  
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1694  	/* CAP.NP sometimes indicate the index of the last enabled
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1695  	 * port, at other times, that of the last possible port, so
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1696  	 * determining the maximum port number requires looking at
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1697  	 * both CAP.NP and port_map.
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1698  	 */
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1699  	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1700  
837f5f8fb9 drivers/ata/ahci.c  Tejun Heo               2008-02-06  1701  	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1702  	if (!host)
24dc5f33ea drivers/ata/ahci.c  Tejun Heo               2007-01-20  1703  		return -ENOMEM;
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1704  	host->private_data = hpriv;
0b9e2988ab drivers/ata/ahci.c  Christoph Hellwig       2016-09-05  1705  
0b9e2988ab drivers/ata/ahci.c  Christoph Hellwig       2016-09-05  1706  	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
0b9e2988ab drivers/ata/ahci.c  Christoph Hellwig       2016-09-05  1707  		/* legacy intx interrupts */
0b9e2988ab drivers/ata/ahci.c  Christoph Hellwig       2016-09-05  1708  		pci_intx(pdev, 1);
0b9e2988ab drivers/ata/ahci.c  Christoph Hellwig       2016-09-05  1709  	}
0ce57f8af1 drivers/ata/ahci.c  Christoph Hellwig       2016-10-25  1710  	hpriv->irq = pci_irq_vector(pdev, 0);
21bfd1aa95 drivers/ata/ahci.c  Robert Richter          2015-05-31  1711  
f3d7f23f87 drivers/ata/ahci.c  Arjan van de Ven        2009-01-26  1712  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
886ad09fc8 drivers/ata/ahci.c  Arjan van de Ven        2009-01-09  1713  		host->flags |= ATA_HOST_PARALLEL_SCAN;
f3d7f23f87 drivers/ata/ahci.c  Arjan van de Ven        2009-01-26  1714  	else
d2782d96f3 drivers/ata/ahci.c  Jingoo Han              2013-10-05  1715  		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
886ad09fc8 drivers/ata/ahci.c  Arjan van de Ven        2009-01-09  1716  
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1717  	if (pi.flags & ATA_FLAG_EM)
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1718  		ahci_reset_em(host);
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1719  
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1720  	for (i = 0; i < host->n_ports; i++) {
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1721  		struct ata_port *ap = host->ports[i];
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1722  
318893e142 drivers/ata/ahci.c  Alessandro Rubini       2012-01-06  1723  		ata_port_pbar_desc(ap, ahci_pci_bar, -1, "abar");
318893e142 drivers/ata/ahci.c  Alessandro Rubini       2012-01-06  1724  		ata_port_pbar_desc(ap, ahci_pci_bar,
cbcdd87593 drivers/ata/ahci.c  Tejun Heo               2007-08-18  1725  				   0x100 + ap->port_no * 0x80, "port");
cbcdd87593 drivers/ata/ahci.c  Tejun Heo               2007-08-18  1726  
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1727  		/* set enclosure management message type */
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1728  		if (ap->flags & ATA_FLAG_EM)
008dbd61eb drivers/ata/ahci.c  Harry Zhang             2010-04-23  1729  			ap->em_message_type = hpriv->em_msg_type;
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1730  
18f7ba4c2f drivers/ata/ahci.c  Kristen Carlson Accardi 2008-06-03  1731  
dab632e8c4 drivers/ata/ahci.c  Jeff Garzik             2007-05-28  1732  		/* disabled/not-implemented port */
350756f6da drivers/ata/ahci.c  Tejun Heo               2008-04-07  1733  		if (!(hpriv->port_map & (1 << i)))
dab632e8c4 drivers/ata/ahci.c  Jeff Garzik             2007-05-28  1734  			ap->ops = &ata_dummy_port_ops;
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1735  	}
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1736  
edc9305284 drivers/ata/ahci.c  Tejun Heo               2007-10-25  1737  	/* apply workaround for ASUS P5W DH Deluxe mainboard */
edc9305284 drivers/ata/ahci.c  Tejun Heo               2007-10-25  1738  	ahci_p5wdh_workaround(host);
edc9305284 drivers/ata/ahci.c  Tejun Heo               2007-10-25  1739  
f80ae7e45a drivers/ata/ahci.c  Tejun Heo               2009-09-16  1740  	/* apply gtf filter quirk */
f80ae7e45a drivers/ata/ahci.c  Tejun Heo               2009-09-16  1741  	ahci_gtf_filter_workaround(host);
f80ae7e45a drivers/ata/ahci.c  Tejun Heo               2009-09-16  1742  
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1743  	/* initialize adapter */
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1744  	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1745  	if (rc)
24dc5f33ea drivers/ata/ahci.c  Tejun Heo               2007-01-20  1746  		return rc;
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1747  
3303040d8b drivers/ata/ahci.c  Anton Vorontsov         2010-03-03  1748  	rc = ahci_pci_reset_controller(host);
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1749  	if (rc)
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1750  		return rc;
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1751  
781d655083 drivers/ata/ahci.c  Anton Vorontsov         2010-03-03  1752  	ahci_pci_init_controller(host);
439fcaec10 drivers/ata/ahci.c  Anton Vorontsov         2010-03-03  1753  	ahci_pci_print_info(host);
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1754  
4447d35156 drivers/ata/ahci.c  Tejun Heo               2007-04-17  1755  	pci_set_master(pdev);
5ca72c4f7c drivers/ata/ahci.c  Alexander Gordeev       2012-11-19  1756  
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1757  	rc = ahci_host_activate(host, &ahci_sht);
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1758  	if (rc)
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1759  		return rc;
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1760  
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18 @1761  	pm_runtime_put_noidle(&pdev->dev);
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1762  	return 0;
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1763  }
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1764  
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1765  static void ahci_remove_one(struct pci_dev *pdev)
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1766  {
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18 @1767  	pm_runtime_get_noresume(&pdev->dev);
02e53293ea drivers/ata/ahci.c  Mika Westerberg         2016-02-18  1768  	ata_pci_remove_one(pdev);
907f4678c1 drivers/scsi/ahci.c Jeff Garzik             2005-05-12  1769  }
^1da177e4c drivers/scsi/ahci.c Linus Torvalds          2005-04-16  1770  

:::::: The code at line 1761 was first introduced by commit
:::::: 02e53293eafcb19b4fabc8a2e7bbfa11b88d0e6c ahci: Add runtime PM support for the host controller

:::::: TO: Mika Westerberg <mika.westerberg@linux.intel.com>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wRRV7LY7NUeQGEoC--
