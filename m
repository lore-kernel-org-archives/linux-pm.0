From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 16:27:24 +0100
Message-ID: <20100504152724.GA2184__36370.2429146089$1272986925$gmane$org@srcf.ucam.org>
References: <20100504004338.GA22678@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005040949060.1729-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005040949060.1729-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 04, 2010 at 09:51:39AM -0400, Alan Stern wrote:

> Another thing that Kevin is missing: There is more to the system than
> the devices and the CPU.  For example: RAM, an embedded controller (on
> modern desktop/laptop systems), a power supply, and so on.  Dynamic PM
> for the CPU and the devices won't power-down these things, but system
> PM will.

Somewhat true - machines with C1E support will put the RAM into self 
refresh when the cpu is idle, but you're right that there are various 
components that we simply don't have control over in the desktop world 
at present.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
