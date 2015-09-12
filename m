From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: bq2415x_charger: Allow to load and use driver even if notify
 device is not registered yet
Date: Sat, 12 Sep 2015 22:50:11 +0300
Message-ID: <20150912195010.GA10112@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32019 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbILTuT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2015 15:50:19 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com
Cc: linux-pm@vger.kernel.org

Hello Pali Roh=E1r,

This is a semi-automatic email about new static checker warnings.

The patch b68c3161430a: "bq2415x_charger: Allow to load and use=20
driver even if notify device is not registered yet" from Aug 11,=20
2015, leads to the following Smatch complaint:

drivers/power/bq2415x_charger.c:1707 bq2415x_probe()
	 error: we previously assumed 'bq' could be null (see line 1581)

drivers/power/bq2415x_charger.c
  1580		bq =3D devm_kzalloc(&client->dev, sizeof(*bq), GFP_KERNEL);
  1581		if (!bq) {
  1582			ret =3D -ENOMEM;
  1583			goto error_2;

"bq" is NULL.

  1584		}

[ snip ]

  1702	error_4:
  1703		bq2415x_sysfs_exit(bq);
  1704	error_3:
  1705		bq2415x_power_supply_exit(bq);
  1706	error_2:
  1707		if (bq->notify_node)

Patch adds a dereference.  Also the GW-BASIC label names are so ugly an=
d
inflexible, it's better to choose meaningful names that say what the
label does like err_sysfs_exit, err_power_supply_exit, and err_node_put=
=2E

  1708			of_node_put(bq->notify_node);\
  1709		kfree(name);

regards,
dan carpenter
