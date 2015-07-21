From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 21 Jul 2015 20:01:15 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948468A923D@fmsmsx115.amr.corp.intel.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <55A668FE.80409@gmail.com>
 <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
 <1684935.fYtBRJbzgO@vostro.rjw.lan> <20150721093806.GA23841@amd>
 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
 <20150721151941.GA19581@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721151941.GA19581@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Who does enter suspend to ram multiple times a second? Only android

One significant customer for fast suspend/resume
is sufficient to justify Linux supporting fast suspend/resume.

> Can you run android on mainline kernel? No

This is something we need to work together to help fix.

thanks,
-Len
