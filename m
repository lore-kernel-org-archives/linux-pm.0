From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:bleeding-edge 94/95] drivers/acpi/apei/apei-base.c:509:21:
 sparse: incorrect type in argument 1 (different base types)
Date: Sat, 16 Dec 2017 12:20:10 +0800
Message-ID: <201712161208.Ou0iMnN5%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   076c5d77b3e3b4898eedf2738f634ef8eabc3970
commit: 43af46822779b067622ba468929daef8f61fbef4 [94/95] ACPI: APEI: Fix allocation and release of memory regions
reproduce:
        # apt-get install sparse
        git checkout 43af46822779b067622ba468929daef8f61fbef4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +509 drivers/acpi/apei/apei-base.c

   466	
   467	/*
   468	 * IO memory/port resource management mechanism is used to check
   469	 * whether memory/port area used by GARs conflicts with normal memory
   470	 * or IO memory/port of devices.
   471	 */
   472	int apei_resources_request(struct apei_resources *resources,
   473				   const char *desc)
   474	{
   475		struct apei_res *res, *res_bak = NULL;
   476		struct resource *r;
   477		struct apei_resources nvs_resources, arch_res;
   478		int rc;
   479	
   480		rc = apei_resources_sub(resources, &apei_resources_all);
   481		if (rc)
   482			return rc;
   483	
   484		/*
   485		 * Some firmware uses ACPI NVS region, that has been marked as
   486		 * busy, so exclude it from APEI resources to avoid false
   487		 * conflict.
   488		 */
   489		apei_resources_init(&nvs_resources);
   490		rc = apei_get_nvs_resources(&nvs_resources);
   491		if (rc)
   492			goto nvs_res_fini;
   493		rc = apei_resources_sub(resources, &nvs_resources);
   494		if (rc)
   495			goto nvs_res_fini;
   496	
   497		if (arch_apei_filter_addr) {
   498			apei_resources_init(&arch_res);
   499			rc = apei_get_arch_resources(&arch_res);
   500			if (rc)
   501				goto arch_res_fini;
   502			rc = apei_resources_sub(resources, &arch_res);
   503			if (rc)
   504				goto arch_res_fini;
   505		}
   506	
   507		rc = -EINVAL;
   508		list_for_each_entry(res, &resources->iomem, list) {
 > 509			r = request_mem_region(res->start, resource_size(res), desc);
   510			if (!r) {
   511				pr_err(APEI_PFX
   512			"Can not request [mem %#010llx-%#010llx] for %s registers\n",
   513				       (unsigned long long)res->start,
   514				       (unsigned long long)res->end - 1, desc);
   515				res_bak = res;
   516				goto err_unmap_iomem;
   517			}
   518		}
   519	
   520		list_for_each_entry(res, &resources->ioport, list) {
   521			r = request_region(res->start, resource_size(res), desc);
   522			if (!r) {
   523				pr_err(APEI_PFX
   524			"Can not request [io  %#06llx-%#06llx] for %s registers\n",
   525				       (unsigned long long)res->start,
   526				       (unsigned long long)res->end - 1, desc);
   527				res_bak = res;
   528				goto err_unmap_ioport;
   529			}
   530		}
   531	
   532		rc = apei_resources_merge(&apei_resources_all, resources);
   533		if (rc) {
   534			pr_err(APEI_PFX "Fail to merge resources!\n");
   535			goto err_unmap_ioport;
   536		}
   537	
   538		goto arch_res_fini;
   539	
   540	err_unmap_ioport:
   541		list_for_each_entry(res, &resources->ioport, list) {
   542			if (res == res_bak)
   543				break;
   544			release_region(res->start, resource_size(res));
   545		}
   546		res_bak = NULL;
   547	err_unmap_iomem:
   548		list_for_each_entry(res, &resources->iomem, list) {
   549			if (res == res_bak)
   550				break;
   551			release_mem_region(res->start, resource_size(res));
   552		}
   553	arch_res_fini:
   554		if (arch_apei_filter_addr)
   555			apei_resources_fini(&arch_res);
   556	nvs_res_fini:
   557		apei_resources_fini(&nvs_resources);
   558		return rc;
   559	}
   560	EXPORT_SYMBOL_GPL(apei_resources_request);
   561	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
