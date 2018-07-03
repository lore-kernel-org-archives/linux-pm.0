From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/2] powernv/cpuidle: Use parsed device tree values
 for cpuidle_init
Date: Tue, 3 Jul 2018 13:31:22 +1000
Message-ID: <20180703133122.245109d0@roar.ozlabs.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
        <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On Mon,  2 Jul 2018 19:53:21 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
