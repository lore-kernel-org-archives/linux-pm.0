From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:58:39 -0700
Message-ID: <200607261758.40587.david-b@pacbell.net>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
	<200607252205.37086.david-b@pacbell.net>
	<44C7DA7A.2040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44C7DA7A.2040608@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Matthew Locke <matt@nomadgs.com>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 July 2006 2:11 pm, Eugeny S. Mints wrote:

> Since UI part seems most painful one I can think of additional splitting
> of PowerOP sysfs layer into two parts. First would be
> powerop_register/unregister_point(), powerop_select_point() and
> another one would be UI sysfs part. And the latter would be optional.

Well, I think it'd be fair to say that something like /sys/power/state
appling to an OP belongs in the core of that framework.  Luckily that
would be straightforward to implmenent, explain, and understand.

- Dave
