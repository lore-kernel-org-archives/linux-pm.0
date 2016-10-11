From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] twl4030_charger: use runtime_pm to keep usb phy active
 while charging.
Date: Tue, 11 Oct 2016 14:30:25 +0300
Message-ID: <20161011113025.GA13807@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17150 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbcJKLap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 07:30:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: neil@brown.name
Cc: linux-pm@vger.kernel.org

Hello NeilBrown,

The patch e57c4a67d712: "twl4030_charger: use runtime_pm to keep usb
phy active while charging." from Jul 30, 2015, leads to the following
static checker warning:

	drivers/power/supply/twl4030_charger.c:521 twl4030_charger_enable_usb()
	error: 'bci->transceiver' dereferencing possible ERR_PTR()

drivers/power/supply/twl4030_charger.c
   468  static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
   469  {
   470          int ret;
   471  
   472          if (bci->usb_mode == CHARGE_OFF)
   473                  enable = false;
   474          if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We assume that ->transceiver can be NULL.

   475  
   476                  twl4030_charger_update_current(bci);
   477  
   478                  /* Need to keep phy powered */
   479                  if (!bci->usb_enabled) {
   480                          pm_runtime_get_sync(bci->transceiver->dev);
   481                          bci->usb_enabled = 1;
   482                  }
   483  
   484                  if (bci->usb_mode == CHARGE_AUTO)
   485                          /* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
   486                          ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
   487  
   488                  /* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
   489                  ret = twl4030_clear_set(TWL_MODULE_MAIN_CHARGE, 0,
   490                          TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
   491                  if (bci->usb_mode == CHARGE_LINEAR) {
   492                          twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
   493                          /* Watch dog key: WOVF acknowledge */
   494                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
   495                                                 TWL4030_BCIWDKEY);
   496                          /* 0x24 + EKEY6: off mode */
   497                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
   498                                                 TWL4030_BCIMDKEY);
   499                          /* EKEY2: Linear charge: USB path */
   500                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x26,
   501                                                 TWL4030_BCIMDKEY);
   502                          /* WDKEY5: stop watchdog count */
   503                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf3,
   504                                                 TWL4030_BCIWDKEY);
   505                          /* enable MFEN3 access */
   506                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x9c,
   507                                                 TWL4030_BCIMFKEY);
   508                           /* ICHGEOCEN - end-of-charge monitor (current < 80mA)
   509                            *                      (charging continues)
   510                            * ICHGLOWEN - current level monitor (charge continues)
   511                            * don't monitor over-current or heat save
   512                            */
   513                          ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf0,
   514                                                 TWL4030_BCIMFEN3);
   515                  }
   516          } else {
   517                  ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOUSB, 0);
   518                  ret |= twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
   519                                          TWL4030_BCIMDKEY);
   520                  if (bci->usb_enabled) {
   521                          pm_runtime_mark_last_busy(bci->transceiver->dev);
                                                          ^^^^^^^^^^^^^^^^^^^^^
But we dereference it here.  Possibly checking ->usb_enabled prevents
a crash?

   522                          pm_runtime_put_autosuspend(bci->transceiver->dev);
   523                          bci->usb_enabled = 0;
   524                  }
   525                  bci->usb_cur = 0;
   526          }
   527  
   528          return ret;
   529  }

regards,
dan carpenter
