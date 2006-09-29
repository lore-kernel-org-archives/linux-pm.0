From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: PowerOP, Whatchanged/Issues/TODO 2/2
Date: Sat, 30 Sep 2006 01:44:12 +0400
Message-ID: <20060930014412.98405be8.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422828AbWI2Vmo@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com, igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

whatchanged:
- new concept of powerop power parameter is introduced
- new powerop core interface routine to set individual(or subset of)
  power parameter value is added
- no more string parsing at any layer
- no more va_list interface 
- powerop driver module refcounting is added
- documentation file including optional sysfs interface description is added

todo/issues:
- better implementation for getting registered operating point names
- configfs for operating points creation from user space
