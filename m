From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] OMAP1 PM Core, Intro 0/2
Date: Sat, 30 Sep 2006 02:24:22 +0400
Message-ID: <20060930022422.4eb949a0.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750813AbWI2WWr@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com, igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

PM Core for OMAP1 platforms.

PM Core provides arch dependent routine to get/set operating points,
hooks up with arhc independent PowerOP layer and utilizes
clock/voltage framework to access hardware. PM Core is expected
to handle additional arch specific actions required to accompany clock/voltage 
framework during operating points change (for example if 
simultaneous coupled clocks/voltage change needs special attention on a 
platform).

Basic building block for PM Core layer is platform power parameter concept. 

Current OMAP implementation relies on "smart" virtual mpu clock
introduced by OMAP1 clock framework (#define
PM_CORE_USE_MPU_CLOCK).

Since voltage framework is not merged into mainline yet
routine to change voltage is temporary implemented in the
PM Core for reference.
