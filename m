From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [soc-thermal:for-kernelci 19/35]
 drivers/thermal/qcom/tsens-v0_1.c:189 calibrate_8974() warn: passing zero
 to 'PTR_ERR'
Date: Wed, 24 Apr 2019 17:14:39 +0300
Message-ID: <20190424141439.GG14820@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Amit Kucheria <amit.kucheria@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, kbuild-all@01.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git for-kernelci
head:   0e50a5ee6b8a23c6798aae23efcd4b8e055c06ef
commit: 5853cb769573b58c319fa62e1987d063b8c5b77e [19/35] drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1

New smatch warnings:
drivers/thermal/qcom/tsens-v0_1.c:228 calibrate_8974() warn: mask and shift to zero

# https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?id=5853cb769573b58c319fa62e1987d063b8c5b77e
git remote add soc-thermal https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
git remote update soc-thermal
git checkout 5853cb769573b58c319fa62e1987d063b8c5b77e
vim +/PTR_ERR +189 drivers/thermal/qcom/tsens-v0_1.c

5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  216  			/* Fall through */
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  217  		case ONE_PT_CALIB:
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  218  		case ONE_PT_CALIB2:
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  219  			base1 = bkp[0] & BASE1_MASK;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  220  			p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  221  			p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  222  			p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  223  			p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  224  			p1[4] = (bkp[1] & S4_P1_MASK);
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  225  			p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  226  			p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  227  			p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20 @228  			p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
                                                                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
p1[8] always ends up being zero.  (I haven't look at the code, that's
what the static checker is saying).


5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  229  			p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  230  			p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  231  			break;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  232  		}
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  233  	} else {
