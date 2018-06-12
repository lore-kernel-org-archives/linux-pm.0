From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH 00/12] Enable PM hibernation on guest VMs
Date: Tue, 12 Jun 2018 17:09:40 -0400
Message-ID: <20180612210940.GA17709@char.us.oracle.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anchal Agarwal <anchalag@amazon.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, boris.ostrovsky@oracle.com, roger.pau@citrix.com, netdev@vger.kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kamatam@amazon.com, fllinden@amazon.com, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 08:56:07PM +0000, Anchal Agarwal wrote:
> Hello,
> I am sending out a series of patches that implements guest
> PM hibernation. These guests are running on xen hypervisor.
> The patches had been tested against mainstream kernel and latest
> xen version-4.11. EC2 instance hibernation feature is provided to
> the AWS EC2 customers. PM hibernation uses swap space where
> hibernation image is stored and restored from. I would like
> the community to review and provide some feedback on the patch 
> series and if they look good, merge them into 4.17 kernel.

4.17 got released on Jun 3rd. Kind of hard to do a time-machine.
