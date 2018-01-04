From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [pm:build-test 122/130] drivers/acpi/acpica/psutils.c:97:27:
 error: implicit declaration of function 'acpi_ut_safe_strncpy'
Date: Thu, 4 Jan 2018 21:44:50 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53966FF7B@ORSMSX110.amr.corp.intel.com>
References: <201801042255.gff4Tm67%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201801042255.gff4Tm67%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

I posted a revision (V2) of this patch to the mailinglist just now.
> -----Original Message-----
> From: Wu, Fengguang
> Sent: Thursday, January 4, 2018 6:29 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: kbuild-all@01.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> pm@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Schmauss, Erik
> <erik.schmauss@intel.com>
> Subject: [pm:build-test 122/130] drivers/acpi/acpica/psutils.c:97:27: error:
> implicit declaration of function 'acpi_ut_safe_strncpy'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git build-
> test
> head:   3fd9789833d2e4a4a10ec7cf20b762290ed50b62
> commit: fe2aa18300b9b49d94e509f045602beca40db0aa [122/130] ACPICA:
> Create and deploy safe version of strncpy
> config: x86_64-randconfig-s2-01042137 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout fe2aa18300b9b49d94e509f045602beca40db0aa
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/acpi/acpica/accommon.h:56:0,
>                     from drivers/acpi/acpica/psutils.c:45:
>    drivers/acpi/acpica/psutils.c: In function 'acpi_ps_init_op':
> >> drivers/acpi/acpica/psutils.c:97:27: error: implicit declaration of function
> 'acpi_ut_safe_strncpy' [-Werror=implicit-function-declaration]
>      ACPI_DISASM_ONLY_MEMBERS(acpi_ut_safe_strncpy(op-
> >common.aml_op_name,
>                               ^
>    drivers/acpi/acpica/aclocal.h:753:41: note: in definition of macro
> 'ACPI_DISASM_ONLY_MEMBERS'
>     #define ACPI_DISASM_ONLY_MEMBERS(a)     a;
>                                             ^
>    cc1: some warnings being treated as errors
> 
> vim +/acpi_ut_safe_strncpy +97 drivers/acpi/acpica/psutils.c
> 
>   > 45	#include "accommon.h"
>     46	#include "acparser.h"
>     47	#include "amlcode.h"
>     48	#include "acconvert.h"
>     49
>     50	#define _COMPONENT          ACPI_PARSER
>     51	ACPI_MODULE_NAME("psutils")
>     52
>     53
> 	/*********************************************************
> **********************
>     54	 *
>     55	 * FUNCTION:    acpi_ps_create_scope_op
>     56	 *
>     57	 * PARAMETERS:  None
>     58	 *
>     59	 * RETURN:      A new Scope object, null on failure
>     60	 *
>     61	 * DESCRIPTION: Create a Scope and associated namepath op with the
> root name
>     62	 *
>     63
> *****************************************************************
> *************/
>     64	union acpi_parse_object *acpi_ps_create_scope_op(u8 *aml)
>     65	{
>     66		union acpi_parse_object *scope_op;
>     67
>     68		scope_op = acpi_ps_alloc_op(AML_SCOPE_OP, aml);
>     69		if (!scope_op) {
>     70			return (NULL);
>     71		}
>     72
>     73		scope_op->named.name = ACPI_ROOT_NAME;
>     74		return (scope_op);
>     75	}
>     76
>     77
> 	/*********************************************************
> **********************
>     78	 *
>     79	 * FUNCTION:    acpi_ps_init_op
>     80	 *
>     81	 * PARAMETERS:  op              - A newly allocated Op object
>     82	 *              opcode          - Opcode to store in the Op
>     83	 *
>     84	 * RETURN:      None
>     85	 *
>     86	 * DESCRIPTION: Initialize a parse (Op) object
>     87	 *
>     88
> *****************************************************************
> *************/
>     89
>     90	void acpi_ps_init_op(union acpi_parse_object *op, u16 opcode)
>     91	{
>     92		ACPI_FUNCTION_ENTRY();
>     93
>     94		op->common.descriptor_type = ACPI_DESC_TYPE_PARSER;
>     95		op->common.aml_opcode = opcode;
>     96
>   > 97		ACPI_DISASM_ONLY_MEMBERS(acpi_ut_safe_strncpy(op-
> >common.aml_op_name,
>     98
> (acpi_ps_get_opcode_info
>     99							       (opcode))->name,
>    100							      sizeof(op-
> >common.
>    101
> aml_op_name)));
>    102	}
>    103
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
