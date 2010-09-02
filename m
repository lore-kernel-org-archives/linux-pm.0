From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during
	suspend
Date: Thu, 2 Sep 2010 16:33:22 +0200
Message-ID: <201009021633.22869.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com>
	<4C7F6931.4050707@gmail.com> <4C7F7649.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C7F7649.3010409@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <htejun@gmail.com>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 02 September 2010, 12:02:49 Tejun Heo wrote:
> For some mysterious reason, certain hardware reacts badly to usual EH
> actions while the system is going for suspend.  As the devices won't
> be needed until the system is resumed, ask EH to skip usual autopsy
> and recovery and proceed directly to suspend.

Thanks Tejun for this patch. Will test in a second!

Cheers,
  Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719  (AMD: 29-719)
