From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [PATCH 2/3] power: core: Add variables related temperature to
 power_supply_info.
Date: Mon, 10 Nov 2014 11:16:32 +0000
Message-ID: <20ADAB092842284E95860F279283C5642ED9EDE3@BGSMSX104.gar.corp.intel.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
 <1412679518-21499-3-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41729 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaKJLRZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 06:17:25 -0500
In-Reply-To: <1412679518-21499-3-git-send-email-jonghwa3.lee@samsung.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>

> @@ -241,6 +241,8 @@ struct power_supply_info {
>  	int charge_empty_design;
>  	int energy_full_design;
>  	int energy_empty_design;
> +	int temperature_max;
> +	int temperature_min;
>  	int use_for_apm;
>  };


The CC,CV and restart threshold would vary based on the battery temperature
So I would suggest to have temperature zone table as part  of battery info
along with other attributes.

int iterm; //charge termination current (used to stop charging)
int temp_zone_count; // number of temperature zone tables present
struct batt_temp_mon_table temp_mon_tbl[MAX_TEMP_MON_TABLE]; //temperature zone table array

struct  batt_temp_mon_table {
	 short int temp_max;
	 short int cc;
	 short int cv;
	 short int vbat_vchk_drop_uv;
	 short int temp_min;
};

-Jenny

