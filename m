Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647286;
	b=urYG4nFgArLnd3GUgMlUiboS0QW4GAB5Mbizx9JS5ZKSTWbuBGUi1dNKKwm5ZeS+7BXV
	 mR38XcGb+LmyZM8CJZJrg7U/ee9VXKSWjrorTgPxE5cXw+N/+vzmC1nLlwja4MA7I4pBt
	 JRreZwCKDfBLX1VMcPu3tDzD593KrvHnxmDmzFYoDJY+/aGkm0oe4HEc9D/2CU15jhYkh
	 iDAaYJJ6ZGeO+WbfyLgve3GdvLSiRRFXDSIbetoyDaYtZPGZ+Tvp6i+ZcqJ7LgITNXeBU
	 bK9yKZ47ZUsKw70ejpvKFMfJa6Uzv7lBHQrqEzZYWOkGOOtVuZgusnDc+ZZNxJiYe4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=n7yFyP7ZXnB/MpU/y/bk7Vp4n82DuO9zcApAbBqLpzA=;
	b=tezCAFlmAMWh2R64sNC/Tx5QMFrF6G540VLfEcsP599mquUbkBbdWkog2S8KlfHKOG/i
	 Pmd1Z/V7ImvdrmK/0tAFn5GjOu5ZOV8ece3KyfH5gzg+Cef8QDEC54tjcye++LM0O+oCd
	 mNnb2Tpr7DnJzBg5q8HEyhjoQSiJlDoo1Kg3ryfVh/G/LamUaqUlTmw9E0afz8HAeM4Lx
	 /qqjvW2CJDpPuqN0Q7dDcEnT8U6ILZQAp+7n8bnx19eY4Fm5VWGyv4xoRcwv+eubn4/Es
	 XRMsrd62KY8SUCv2mBbiFzzMyQqY+zGx3oWNa/zkZnGknXQUFKeQ2Ph3qkANyQaj9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IELDVAXa;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08061606A689;
	Wed, 25 Nov 2026 22:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08061606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IELDVAXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795647286; x=1827183286;
  h=date:from:to:cc:subject:message-id;
  bh=d2YRxS7xpesqBMM6B4z2PnG5qmi2zb95+BAh/N1HAxc=;
  b=IELDVAXa6eQHRkB8AeRlKkqFGXqx8Av92tNcjOAZGLtjZoEcH7+T/dho
   p2Dzi85KqtuVzFKqhFy2yZtth2QofOatyCacsOiZhyAwoxByhL3ZVOvJY
   EBG8Vsb+vWye33zqR1QA71b6TLm2nJwb5VoD1YwKY3+QhWIyXeyR9iQXa
   rJTO2Bys8qc0FF4+T9/q/qEOCBTutXRoJUJaQeDBi8CCnuv5WqMra863J
   nN35QeWbt5IRIQMHx5pQhkZEQlqvyu3w3KhZvRoSJaFkrV9G0TfpPKGGS
   0+qUcCKqL42bL8ExhtCO/2mKLMrLjYqwxuJHdUvYRIQWA6AmZ48YF+IV3
   w==;
X-CSE-ConnectionGUID: T7nyXwK1Rhq2e7A4uv6T1w==
X-CSE-MsgGUID: cn7oO2THRhSBCTHME5rW6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4453572"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4453572"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:54:45 -0800
X-CSE-ConnectionGUID: 46RVucZiRLiEGWQ+t0uiew==
X-CSE-MsgGUID: 2d91PRc/R2+K5FCZyIQVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11883154"
Received: from igk-lkp-server01.igk.intel.com (HELO a03d4d989450) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2026 14:54:43 -0800
Received: from kbuild by a03d4d989450 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWLsu-0000000007r-0CpB;
	Wed, 25 Nov 2026 22:54:40 +0000
Date: Wed, 25 Nov 2026 23:54:01 +0100
From: kernel test robot <lkp@intel.com>
To: "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 183/194]
 drivers/acpi/acpica/evgpe.c:706 acpi_ev_clear_gpe_dispatch_by_owner() warn:
 inconsistent indenting
Message-ID: <20261125234605.yAGraiIA-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   a2760eeb5e110a0a1a9c926183abb022b400aa3b
commit: b9a3ceee0af1e7255835e3a025879ee2c9b4a826 [183/194] ACPICA: events: Fix GPE cleanup return after changing program state
config: x86_64-randconfig-2200-20261125 (https://download.01.org/0day-ci/archive/20261125/20261125234605.yAGraiIA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125234605.yAGraiIA-lkp@intel.com/

smatch warnings:
drivers/acpi/acpica/evgpe.c:706 acpi_ev_clear_gpe_dispatch_by_owner() warn: inconsistent indenting

vim +706 drivers/acpi/acpica/evgpe.c

6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  598  
3f013ec0f167d3e ikaros                2026-11-20  599  /*******************************************************************************
3f013ec0f167d3e ikaros                2026-11-20  600   *
3f013ec0f167d3e ikaros                2026-11-20  601   * FUNCTION:    acpi_ev_clear_gpe_dispatch_by_owner
3f013ec0f167d3e ikaros                2026-11-20  602   *
3f013ec0f167d3e ikaros                2026-11-20  603   * PARAMETERS:  owner_id        - Table owner_id being unloaded
3f013ec0f167d3e ikaros                2026-11-20  604   *
3f013ec0f167d3e ikaros                2026-11-20  605   * RETURN:      Status
3f013ec0f167d3e ikaros                2026-11-20  606   *
3f013ec0f167d3e ikaros                2026-11-20  607   * DESCRIPTION: Clear GPE dispatch info for methods belonging to the table
3f013ec0f167d3e ikaros                2026-11-20  608   *              being unloaded. If any matching GPE is currently dispatching,
3f013ec0f167d3e ikaros                2026-11-20  609   *              it is not cleared and AE_ABORT_METHOD is returned.
3f013ec0f167d3e ikaros                2026-11-20  610   *
3f013ec0f167d3e ikaros                2026-11-20  611   ******************************************************************************/
3f013ec0f167d3e ikaros                2026-11-20  612  
3f013ec0f167d3e ikaros                2026-11-20  613  acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
3f013ec0f167d3e ikaros                2026-11-20  614  {
3f013ec0f167d3e ikaros                2026-11-20  615  	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
3f013ec0f167d3e ikaros                2026-11-20  616  	struct acpi_gpe_block_info *gpe_block;
3f013ec0f167d3e ikaros                2026-11-20  617  	struct acpi_gpe_event_info *gpe_event_info;
3f013ec0f167d3e ikaros                2026-11-20  618  	u32 gpe_number;
3f013ec0f167d3e ikaros                2026-11-20  619  	acpi_cpu_flags flags;
3f013ec0f167d3e ikaros                2026-11-20  620  	acpi_status status = AE_OK;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  621  	u32 gpe_dispatch_type;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  622  	struct acpi_gpe_handler_info *handler;
3f013ec0f167d3e ikaros                2026-11-20  623  
3f013ec0f167d3e ikaros                2026-11-20  624  	ACPI_FUNCTION_TRACE_U32(ev_clear_gpe_dispatch_by_owner, owner_id);
3f013ec0f167d3e ikaros                2026-11-20  625  
3f013ec0f167d3e ikaros                2026-11-20  626  	if (owner_id == 0) {
3f013ec0f167d3e ikaros                2026-11-20  627  		return_ACPI_STATUS(AE_OK);
3f013ec0f167d3e ikaros                2026-11-20  628  	}
3f013ec0f167d3e ikaros                2026-11-20  629  
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  630  	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  631  	if (ACPI_FAILURE(status)) {
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  632  		return_ACPI_STATUS(status);
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  633  	}
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  634  
3f013ec0f167d3e ikaros                2026-11-20  635  	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
3f013ec0f167d3e ikaros                2026-11-20  636  
3f013ec0f167d3e ikaros                2026-11-20  637  	/* Walk all GPE interrupt blocks */
3f013ec0f167d3e ikaros                2026-11-20  638  
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  639  	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  640  	while (gpe_xrupt_info) {
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  641  		gpe_block = gpe_xrupt_info->gpe_block_list_head;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  642  		while (gpe_block) {
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  643  			/*
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  644  			 * Walk all GPEs in this block to make sure none are blocked from
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  645  			 * getting cleared with disable_for_dispatch
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  646  			 */
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  647  
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  648  			for (gpe_number = 0; gpe_number < gpe_block->gpe_count;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  649  			     gpe_number++) {
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  650  				gpe_event_info =
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  651  					&gpe_block->event_info[gpe_number];
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  652  				gpe_dispatch_type =
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  653  					acpi_ev_dispatch_type_hidden_handler(
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  654  						gpe_event_info, owner_id);
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  655  				if ((gpe_dispatch_type ==
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  656  					     ACPI_GPE_DISPATCH_METHOD ||
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  657  				     gpe_dispatch_type ==
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  658  					     ACPI_GPE_DISPATCH_NOTIFY) &&
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  659  				    gpe_event_info->disable_for_dispatch) {
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  660  					/* At least one handler is polling or executing, cannot clear */
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  661  					status = AE_ABORT_METHOD;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  662  					acpi_os_release_lock(acpi_gbl_gpe_lock,
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  663  							     flags);
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  664  					(void)acpi_ut_release_mutex(
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  665  						ACPI_MTX_EVENTS);
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  666  					return_ACPI_STATUS(status);
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  667  				}
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  668  			}
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  669  
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  670  			gpe_block = gpe_block->next;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  671  		}
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  672  
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  673  		gpe_xrupt_info = gpe_xrupt_info->next;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  674  	}
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  675  
3f013ec0f167d3e ikaros                2026-11-20  676  	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
3f013ec0f167d3e ikaros                2026-11-20  677  	while (gpe_xrupt_info) {
3f013ec0f167d3e ikaros                2026-11-20  678  		gpe_block = gpe_xrupt_info->gpe_block_list_head;
3f013ec0f167d3e ikaros                2026-11-20  679  		while (gpe_block) {
3f013ec0f167d3e ikaros                2026-11-20  680  			/* Walk all GPEs in this block */
3f013ec0f167d3e ikaros                2026-11-20  681  
3f013ec0f167d3e ikaros                2026-11-20  682  			for (gpe_number = 0; gpe_number < gpe_block->gpe_count;
3f013ec0f167d3e ikaros                2026-11-20  683  			     gpe_number++) {
3f013ec0f167d3e ikaros                2026-11-20  684  				gpe_event_info =
3f013ec0f167d3e ikaros                2026-11-20  685  					&gpe_block->event_info[gpe_number];
3f013ec0f167d3e ikaros                2026-11-20  686  
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  687  				gpe_dispatch_type =
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  688  					acpi_ev_dispatch_type_hidden_handler(
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  689  						gpe_event_info, owner_id);
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  690  				switch (gpe_dispatch_type) {
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  691  				case ACPI_GPE_DISPATCH_METHOD:
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  692  					/*
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  693  					 * GPE method belongs to table being unloaded. Clear
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  694  					 * only the dispatch type, preserve other flags.
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  695  					 */
3f013ec0f167d3e ikaros                2026-11-20  696  						gpe_event_info->flags &=
3f013ec0f167d3e ikaros                2026-11-20  697  							~ACPI_GPE_DISPATCH_MASK;
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  698  					gpe_event_info->dispatch.method_node =
b9a3ceee0af1e72 Maciej Wieczor-Retman 2026-11-20  699  						NULL;
3f013ec0f167d3e ikaros                2026-11-20  700  
3f013ec0f167d3e ikaros                2026-11-20  701  						/*
3f013ec0f167d3e ikaros                2026-11-20  702  						 * Hardware-disable the GPE so a late interrupt
3f013ec0f167d3e ikaros                2026-11-20  703  						 * cannot fire and land in the "no handler" default
3f013ec0f167d3e ikaros                2026-11-20  704  						 * branch with disable_for_dispatch stuck at TRUE.
3f013ec0f167d3e ikaros                2026-11-20  705  						 */
3f013ec0f167d3e ikaros                2026-11-20 @706  						(void)acpi_hw_low_set_gpe(
3f013ec0f167d3e ikaros                2026-11-20  707  							gpe_event_info,
3f013ec0f167d3e ikaros                2026-11-20  708  							ACPI_GPE_DISABLE);
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  709  					break;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  710  
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  711  				case ACPI_GPE_DISPATCH_HANDLER:
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  712  				case ACPI_GPE_DISPATCH_RAW_HANDLER:
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  713  
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  714  					handler =
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  715  						gpe_event_info->dispatch.handler;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  716  					gpe_dispatch_type =
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  717  						ACPI_GPE_DISPATCH_TYPE(
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  718  							handler->original_flags);
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  719  
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  720  					/* Forget the hidden method so handler removal can't restore it */
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  721  					if (gpe_dispatch_type ==
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  722  					    ACPI_GPE_DISPATCH_METHOD) {
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  723  						handler->method_node = NULL;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  724  						handler->original_flags &=
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  725  							~ACPI_GPE_DISPATCH_MASK; /* -> NONE */
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  726  						handler->originally_enabled =
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  727  							FALSE;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  728  					}
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  729  					break;
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  730  
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  731  				default:
6ee1202890b74c6 Maciej Wieczor-Retman 2026-11-20  732  					break;
3f013ec0f167d3e ikaros                2026-11-20  733  				}
3f013ec0f167d3e ikaros                2026-11-20  734  			}
3f013ec0f167d3e ikaros                2026-11-20  735  
3f013ec0f167d3e ikaros                2026-11-20  736  			gpe_block = gpe_block->next;
3f013ec0f167d3e ikaros                2026-11-20  737  		}
3f013ec0f167d3e ikaros                2026-11-20  738  
3f013ec0f167d3e ikaros                2026-11-20  739  		gpe_xrupt_info = gpe_xrupt_info->next;
3f013ec0f167d3e ikaros                2026-11-20  740  	}
3f013ec0f167d3e ikaros                2026-11-20  741  
3f013ec0f167d3e ikaros                2026-11-20  742  	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
ec725d1bc3be3f3 Maciej Wieczor-Retman 2026-11-20  743  	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
3f013ec0f167d3e ikaros                2026-11-20  744  	return_ACPI_STATUS(status);
3f013ec0f167d3e ikaros                2026-11-20  745  }
3f013ec0f167d3e ikaros                2026-11-20  746  

:::::: The code at line 706 was first introduced by commit
:::::: 3f013ec0f167d3e814399286690b672365662e78 ACPICA: Events: Clear GPE dispatch by owner during table unload

:::::: TO: ikaros <void0red@gmail.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
