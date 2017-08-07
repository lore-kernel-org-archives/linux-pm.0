From: Vinay Simha B N <simhavcs@gmail.com>
Subject: Re: [PATCH] power: smb347-charger: Summit SMB358 charger IC
Date: Mon, 7 Aug 2017 12:22:57 +0530
Message-ID: <CAGWqDJ5B9ypdK4rNqdcVCiyzPpbJ0DsYKAydU1JJ+-BmcpW5cQ@mail.gmail.com>
References: <1501613430-24508-1-git-send-email-simhavcs@gmail.com> <201708030521.CLrgdI2G%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201708030521.CLrgdI2G%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

In the config attached. CONFIG_GPIOLIB is not set. please set and recompile

fyi,
devm_gpiod_get() declared in drivers/gpio/devres.c -> CONFIG_GPIOLIB

On Thu, Aug 3, 2017 at 3:28 AM, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Vinay,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.13-rc3 next-20170802]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Vinay-Simha-BN/power-smb347-charger-Summit-SMB358-charger-IC/20170802-054147
> config: x86_64-randconfig-b0-08030519 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/power/supply/smb347-charger.c: In function 'smb347_probe':
> >> drivers/power/supply/smb347-charger.c:1341:24: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
>      smb->pdata->en_gpio = devm_gpiod_get(dev, "en", GPIOD_OUT_HIGH);
>                            ^~~~~~~~~~~~~~
> >> drivers/power/supply/smb347-charger.c:1341:50: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
>      smb->pdata->en_gpio = devm_gpiod_get(dev, "en", GPIOD_OUT_HIGH);
>                                                      ^~~~~~~~~~~~~~
>    drivers/power/supply/smb347-charger.c:1341:50: note: each undeclared identifier is reported only once for each function it appears in
>    cc1: some warnings being treated as errors
>
> vim +/devm_gpiod_get +1341 drivers/power/supply/smb347-charger.c
>
>   1273
>   1274  static int smb347_probe(struct i2c_client *client,
>   1275                          const struct i2c_device_id *id)
>   1276  {
>   1277          struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
>   1278          struct device *dev = &client->dev;
>   1279          struct smb347_charger *smb;
>   1280          int ret;
>   1281
>   1282          smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
>   1283          if (!smb)
>   1284                  return -ENOMEM;
>   1285
>   1286          smb->pdata = smb347_get_platdata(dev);
>   1287          if (IS_ERR_OR_NULL(smb->pdata))
>   1288                  return -ENODEV;
>   1289
>   1290          if (!smb->pdata->use_mains && !smb->pdata->use_usb)
>   1291                  return -EINVAL;
>   1292
>   1293          i2c_set_clientdata(client, smb);
>   1294
>   1295          mutex_init(&smb->lock);
>   1296          smb->id = id->driver_data;
>   1297          smb->dev = &client->dev;
>   1298
>   1299          smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
>   1300          if (IS_ERR(smb->regmap))
>   1301                  return PTR_ERR(smb->regmap);
>   1302
>   1303          ret = smb347_hw_init(smb);
>   1304          if (ret < 0)
>   1305                  return ret;
>   1306
>   1307          mains_usb_cfg.supplied_to = battery;
>   1308          mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
>   1309          mains_usb_cfg.drv_data = smb;
>   1310          if (smb->pdata->use_mains) {
>   1311                  smb->mains = power_supply_register(dev, &smb347_mains_desc,
>   1312                                                     &mains_usb_cfg);
>   1313                  if (IS_ERR(smb->mains))
>   1314                          return PTR_ERR(smb->mains);
>   1315          }
>   1316
>   1317          if (smb->pdata->use_usb) {
>   1318                  smb->usb = power_supply_register(dev, &smb347_usb_desc,
>   1319                                                   &mains_usb_cfg);
>   1320                  if (IS_ERR(smb->usb)) {
>   1321                          if (smb->pdata->use_mains)
>   1322                                  power_supply_unregister(smb->mains);
>   1323                          return PTR_ERR(smb->usb);
>   1324                  }
>   1325          }
>   1326
>   1327          battery_cfg.drv_data = smb;
>   1328          smb->battery = power_supply_register(dev, &smb347_battery_desc,
>   1329                                               &battery_cfg);
>   1330          if (IS_ERR(smb->battery)) {
>   1331                  if (smb->pdata->use_usb)
>   1332                          power_supply_unregister(smb->usb);
>   1333                  if (smb->pdata->use_mains)
>   1334                          power_supply_unregister(smb->mains);
>   1335                  return PTR_ERR(smb->battery);
>   1336          }
>   1337
>   1338          /*
>   1339           * EN - enable input can be controlled by i2c or gpio.
>   1340           */
> > 1341          smb->pdata->en_gpio = devm_gpiod_get(dev, "en", GPIOD_OUT_HIGH);
>   1342          if (IS_ERR(smb->pdata->en_gpio)) {
>   1343                  ret = PTR_ERR(smb->pdata->en_gpio);
>   1344                  dev_err(dev, "cannot get en-gpio %d\n", ret);
>   1345                  dev_dbg(smb->dev, "charging enable/disable in SW enabled\n");
>   1346
>   1347                  smb->pdata->enable_control = SMB347_CHG_ENABLE_SW;
>   1348          } else {
>   1349                  smb->pdata->enable_control = SMB347_CHG_ENABLE_PIN_ACTIVE_HIGH;
>   1350          }
>   1351
>   1352          /*
>   1353           * Interrupt pin is optional. If it is connected, we setup the
>   1354           * interrupt support here.
>   1355           */
>   1356          if (smb->pdata->irq_gpio >= 0) {
>   1357                  ret = smb347_irq_init(smb, client);
>   1358                  if (ret < 0) {
>   1359                          dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
>   1360                          dev_warn(dev, "disabling IRQ support\n");
>   1361                  } else {
>   1362                          smb347_irq_enable(smb);
>   1363                  }
>   1364          }
>   1365
>   1366          return 0;
>   1367  }
>   1368
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation




-- 
regards,
vinaysimha
