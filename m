From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] power: surface3_power: MSHW0011 rev-eng
 implementation
Date: Mon, 1 Aug 2016 11:09:56 +0200
Message-ID: <20160801090956.GS19383@mail.corp.redhat.com>
References: <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
 <201607300326.Jz627ERh%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201607300326.Jz627ERh%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Jul 30 2016 or thereabouts, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on battery/master]
> [also build test ERROR on v4.7 next-20160729]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/Add-support-for-Microsoft-Surface-3-power/20160729-235348
> base:   git://git.infradead.org/battery-2.6.git master
> config: tile-allyesconfig (attached as .config)
> compiler: tilegx-linux-gcc (GCC) 4.6.2
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile 

I guess adding depends on ACPI in the Kconfig should prevent those
architectures to be compiled as a target.

Will submit a v2 when I get around the issues raised by Lv in 1/2
regarding the ACPICA bits.

Cheers,
Benjamin

> 
> All errors (new ones prefixed by >>):
> 
>    drivers/power/surface3_power.c:52:52: error: expected ')' before 'bool'
>    drivers/power/surface3_power.c:54:4: error: expected ')' before string constant
>    drivers/power/surface3_power.c: In function 'mshw0011_notify':
>    drivers/power/surface3_power.c:199:2: error: implicit declaration of function 'acpi_bus_get_device'
>    drivers/power/surface3_power.c:202:2: error: implicit declaration of function 'acpi_evaluate_dsm_typed'
>    drivers/power/surface3_power.c:202:6: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/power/surface3_power.c: In function 'mshw0011_space_handler':
>    drivers/power/surface3_power.c:441:23: error: 'ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS' undeclared (first use in this function)
>    drivers/power/surface3_power.c:441:23: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/power/surface3_power.c: In function 'mshw0011_install_space_handler':
>    drivers/power/surface3_power.c:511:2: error: implicit declaration of function 'acpi_bus_attach_private_data'
>    drivers/power/surface3_power.c:524:3: error: implicit declaration of function 'acpi_bus_detach_private_data'
>    drivers/power/surface3_power.c:529:2: error: implicit declaration of function 'acpi_walk_dep_device_list'
>    drivers/power/surface3_power.c: In function 'mshw0011_remove_space_handler':
>    drivers/power/surface3_power.c:548:2: error: implicit declaration of function 'acpi_bus_get_private_data'
>    drivers/power/surface3_power.c: In function 'mshw0011_i2c_resource_lookup':
>    drivers/power/surface3_power.c:582:2: error: implicit declaration of function 'acpi_dev_get_resources'
>    drivers/power/surface3_power.c:586:2: error: implicit declaration of function 'acpi_dev_free_resource_list'
>    drivers/power/surface3_power.c:571:21: warning: unused variable 'client'
>    drivers/power/surface3_power.c: At top level:
>    drivers/power/surface3_power.c:701:1: warning: data definition has no type or storage class [enabled by default]
>    drivers/power/surface3_power.c:701:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
>    drivers/power/surface3_power.c:701:1: warning: parameter names (without types) in function declaration [enabled by default]
>    drivers/power/surface3_power.c:720:1: warning: data definition has no type or storage class [enabled by default]
> >> drivers/power/surface3_power.c:720:1: error: type defaults to 'int' in declaration of 'module_init'
>    drivers/power/surface3_power.c:720:1: warning: parameter names (without types) in function declaration [enabled by default]
>    drivers/power/surface3_power.c:720:1: warning: data definition has no type or storage class [enabled by default]
> >> drivers/power/surface3_power.c:720:1: error: type defaults to 'int' in declaration of 'module_exit'
>    drivers/power/surface3_power.c:720:1: warning: parameter names (without types) in function declaration [enabled by default]
>    drivers/power/surface3_power.c:722:15: error: expected declaration specifiers or '...' before string constant
>    drivers/power/surface3_power.c:723:20: error: expected declaration specifiers or '...' before string constant
>    drivers/power/surface3_power.c:724:16: error: expected declaration specifiers or '...' before string constant
>    drivers/power/surface3_power.c:720:1: warning: 'mshw0011_driver_init' defined but not used
>    cc1: some warnings being treated as errors
> 
> vim +720 drivers/power/surface3_power.c
> 
>    565		return 1;
>    566	}
>    567	
>    568	static int mshw0011_i2c_resource_lookup(struct mshw0011_data *cdata,
>    569						unsigned int index)
>    570	{
>  > 571		struct i2c_client *client = cdata->adp1;
>    572		struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>    573		struct mshw0011_lookup lookup = {
>    574			.cdata = cdata,
>    575			.index = index,
>    576		};
>    577		struct list_head res_list;
>    578		int ret;
>    579	
>    580		INIT_LIST_HEAD(&res_list);
>    581	
>  > 582		ret = acpi_dev_get_resources(adev, &res_list, acpi_find_i2c, &lookup);
>    583		if (ret < 0)
>    584			return ret;
>    585	
>    586		acpi_dev_free_resource_list(&res_list);
>    587	
>    588		if (!lookup.addr)
>    589			return -ENOENT;
>    590	
>    591		return lookup.addr;
>    592	}
>    593	
>    594	static void mshw0011_dump_registers(struct i2c_client *client,
>    595					    struct i2c_client *bat0, u8 max)
>    596	{
>    597		char rd_buf[60];
>    598		int error, i, c;
>    599		char buff[17 * 3 * 2] = {0};
>    600	
>    601		dev_info(&client->dev, "dumping registers 0x00 to 0x%02x:\n",
>    602			 (max - 1) / 0x20 * 0x20 + 0x1f);
>    603	
>    604		for (i = 0; i < max; i += 0x20) {
>    605			memset(rd_buf, 0, sizeof(rd_buf));
>    606			error = mshw0011_i2c_read_block(bat0, i, rd_buf, 0x20);
>    607			dev_info(&client->dev, " read 0x%02x: %*ph|%*ph\n",
>    608				 i,
>    609				 0x10, rd_buf,
>    610				 0x10, rd_buf + 0x10);
>    611			for (c = 0; c < 0x20; c++) {
>    612				if (rd_buf[c] >= 0x20 && rd_buf[c] <= 0x7e) {
>    613					buff[c * 3 + 0] = ' ';
>    614					buff[c * 3 + 1] = rd_buf[c];
>    615				} else {
>    616					buff[c * 3 + 0] = '-';
>    617					buff[c * 3 + 1] = '-';
>    618				}
>    619				buff[c * 3 + 2] = (c + 1) % 0x10 ? ' ' : '|';
>    620			}
>    621			buff[0x1f * 3 + 2] = '\0';
>    622			dev_info(&client->dev, "ascii 0x%02x: %s\n", i, buff);
>    623		}
>    624	}
>    625	
>    626	static int mshw0011_probe(struct i2c_client *client,
>    627				  const struct i2c_device_id *id)
>    628	{
>    629		struct device *dev = &client->dev;
>    630		struct i2c_client *bat0;
>    631		struct mshw0011_data *data;
>    632		int error, version, addr;
>    633	
>    634		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>    635		if (!data)
>    636			return -ENOMEM;
>    637	
>    638		data->adp1 = client;
>    639		i2c_set_clientdata(client, data);
>    640	
>    641		addr = mshw0011_i2c_resource_lookup(data, 1);
>    642		if (addr < 0)
>    643			return addr;
>    644	
>    645		bat0 = i2c_new_dummy(client->adapter, addr);
>    646		if (!bat0)
>    647			return -ENOMEM;
>    648	
>    649		data->bat0 = bat0;
>    650		i2c_set_clientdata(bat0, data);
>    651	
>    652		if (dump_registers) {
>    653			mshw0011_dump_registers(client, client, 0xFF);
>    654			mshw0011_dump_registers(client, bat0, 0x80);
>    655		}
>    656	
>    657		error = mshw0011_notify(data, 1, MSHW0011_NOTIFY_GET_VERSION, &version);
>    658		if (error)
>    659			goto out_err;
>    660	
>    661		data->notify_version = version == MSHW0011_EV_2_5;
>    662	
>    663		data->poll_task = kthread_run(mshw0011_poll_task, data, "mshw0011_adp");
>    664		if (IS_ERR(data->poll_task)) {
>    665			error = PTR_ERR(data->poll_task);
>    666			dev_err(&client->dev, "Unable to run kthread err %d\n", error);
>    667			goto out_err;
>    668		}
>    669	
>    670		error = mshw0011_install_space_handler(client);
>    671		if (error)
>    672			goto out_err;
>    673	
>    674		return 0;
>    675	
>    676	out_err:
>    677		if (data->kthread_running)
>    678			kthread_stop(data->poll_task);
>    679		i2c_unregister_device(data->bat0);
>    680		return error;
>    681	}
>    682	
>    683	static int mshw0011_remove(struct i2c_client *client)
>    684	{
>    685		struct mshw0011_data *cdata = i2c_get_clientdata(client);
>    686	
>    687		mshw0011_remove_space_handler(client);
>    688	
>    689		if (cdata->kthread_running)
>    690			kthread_stop(cdata->poll_task);
>    691	
>    692		i2c_unregister_device(cdata->bat0);
>    693	
>    694		return 0;
>    695	}
>    696	
>    697	static const struct i2c_device_id mshw0011_id[] = {
>    698		{ "MSHW0011:00", 0 },
>    699		{ }
>    700	};
>    701	MODULE_DEVICE_TABLE(i2c, mshw0011_id);
>    702	
>    703	#ifdef CONFIG_ACPI
>    704	static const struct acpi_device_id mshw0011_acpi_match[] = {
>    705		{ "MSHW0011", 0 },
>    706		{ }
>    707	};
>    708	MODULE_DEVICE_TABLE(acpi, mshw0011_acpi_match);
>    709	#endif
>    710	
>    711	static struct i2c_driver mshw0011_driver = {
>    712		.probe = mshw0011_probe,
>    713		.remove = mshw0011_remove,
>    714		.id_table = mshw0011_id,
>    715		.driver = {
>    716			.name = "mshw0011",
>    717			.acpi_match_table = ACPI_PTR(mshw0011_acpi_match),
>    718		},
>    719	};
>  > 720	module_i2c_driver(mshw0011_driver);
>    721	
>    722	MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>    723	MODULE_DESCRIPTION("mshw0011 driver");
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


