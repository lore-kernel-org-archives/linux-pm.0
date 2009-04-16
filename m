From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 17:40:44 -0700
Message-ID: <d6200be20904151740s65eb4132l1df50eec96b47849@mail.gmail.com>
References: <1239759692-28617-2-git-send-email-arve@android.com>
	<Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
	<20090415190811.GB3679@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090415190811.GB3679@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 15, 2009 at 12:08 PM, mark gross <mgross@linux.intel.com> wrote:
> I'm still re-reviewing the design so I probably should keep my mouth
> shut, but I only see code for constraining entry into suspend state (S3
> if you will) =A0I didn't see code that would get called to block device
> entry into higher power states just constraints on entire system entry
> into sleep state. =A0(I apologize if I missed that code and will happily
> eat my words if needed.)
>

I removed the idle wake lock type since it had too much overlap with
pm_qos. Are there any references to them left in the documentation?

-- =

Arve Hj=F8nnev=E5g
