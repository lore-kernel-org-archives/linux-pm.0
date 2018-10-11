From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [workqueue/driver-core PATCH v2 4/5] driver core: Attach devices
 on CPU local to device node
Date: Thu, 11 Oct 2018 12:45:01 +0200
Message-ID: <20181011104501.GA30183@kroah.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230836.10609.73485.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010230836.10609.73485.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 04:08:40PM -0700, Alexander Duyck wrote:
> This change makes it so that we call the asynchronous probe routines on a
> CPU local to the device node. By doing this we should be able to improve
> our initialization time significantly as we can avoid having to access the
> device from a remote node which may introduce higher latency.

This is nice in theory, but what kind of real numbers does this show?
There's a lot of added complexity here, and what is the benifit?

Benchmarks or bootcharts that we can see would be great to have, thanks.

greg k-h
