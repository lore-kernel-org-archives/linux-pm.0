From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 18 Oct 2018 11:11:15 -0700
Message-ID: <1539886275.81977.17.camel@acm.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150926.29520.45280.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015150926.29520.45280.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
+AD4 +-static void +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper(void +ACoAXw-dev, async+AF8-cookie+AF8-t cookie)
+AD4 +-+AHs
+AD4 +-	struct device +ACo-dev +AD0 +AF8-dev+ADs
+AD4 +-
+AD4 +-	+AF8AXw-device+AF8-driver+AF8-lock(dev, dev-+AD4-parent)+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo If someone attempted to bind a driver either successfully or
+AD4 +-	 +ACo unsuccessfully before we got here we should just skip the driver
+AD4 +-	 +ACo probe call.
+AD4 +-	 +ACo-/
+AD4 +-	if (+ACE-dev-+AD4-driver) +AHs
+AD4 +-		struct device+AF8-driver +ACo-drv +AD0 dev+AF8-get+AF8-drvdata(dev)+ADs
+AD4 +-
+AD4 +-		if (drv)
+AD4 +-			driver+AF8-probe+AF8-device(drv, dev)+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-	+AF8AXw-device+AF8-driver+AF8-unlock(dev, dev-+AD4-parent)+ADs
+AD4 +-
+AD4 +-	put+AF8-device(dev)+ADs
+AD4 +-
+AD4 +-	dev+AF8-dbg(dev, +ACI-async probe completed+AFw-n+ACI)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  static int +AF8AXw-driver+AF8-attach(struct device +ACo-dev, void +ACo-data)
+AD4  +AHs
+AD4  	struct device+AF8-driver +ACo-drv +AD0 data+ADs
+AD4 +AEAAQA -945,6 +-971,25 +AEAAQA static int +AF8AXw-driver+AF8-attach(struct device +ACo-dev, void +ACo-data)
+AD4  		return ret+ADs
+AD4  	+AH0 /+ACo ret +AD4 0 means positive match +ACo-/
+AD4  
+AD4 +-	if (driver+AF8-allows+AF8-async+AF8-probing(drv)) +AHs
+AD4 +-		/+ACo
+AD4 +-		 +ACo Instead of probing the device synchronously we will
+AD4 +-		 +ACo probe it asynchronously to allow for more parallelism.
+AD4 +-		 +ACo
+AD4 +-		 +ACo We only take the device lock here in order to guarantee
+AD4 +-		 +ACo that the dev-+AD4-driver and driver+AF8-data fields are protected
+AD4 +-		 +ACo-/
+AD4 +-		dev+AF8-dbg(dev, +ACI-scheduling asynchronous probe+AFw-n+ACI)+ADs
+AD4 +-		device+AF8-lock(dev)+ADs
+AD4 +-		if (+ACE-dev-+AD4-driver) +AHs
+AD4 +-			get+AF8-device(dev)+ADs
+AD4 +-			dev+AF8-set+AF8-drvdata(dev, drv)+ADs
+AD4 +-			async+AF8-schedule(+AF8AXw-driver+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4 +-		+AH0
+AD4 +-		device+AF8-unlock(dev)+ADs
+AD4 +-		return 0+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4  	device+AF8-driver+AF8-attach(drv, dev)+ADs

What prevents that the driver pointer becomes invalid after async+AF8-schedule() has
been called and before +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper() is called? I think we need
protection against concurrent driver+AF8-unregister() and +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper()
calls. I'm not sure whether that is possible without introducing a new mutex.

Thanks,

Bart.
