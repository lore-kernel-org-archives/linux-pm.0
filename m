From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: PM state dependencies
Date: Thu, 24 Mar 2005 10:45:57 +1100
Message-ID: <1111621557.19905.115.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============50107713590061587=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============50107713590061587==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, I'm starting a new thread for this one, it's getting messy...

So, my initial proposal, was to have a simple dependency mecanism in the
core, that consist of having driver state indicate their depedencies on
parent states (either an integer or a bit mask). However, that requires
ordering of states (from "low" to "high" power) in order to properly
deal with calling the child before/after and some people, notably David,
disagree with the model.

I'm not 100% "pro" my proposed model, it is again just an idea I had
that I think would solve the majority of cases. Maybe we can do
something a bit more flexible. We remove the dependency information, and
we put it back under driver (child) responsibility, and to deal with
that, what we do is add 2 routines  to the device:
parent_state_will_change() and parent_state_changed().

They are called on all childs respectively before and after a parent
state change. No need for the core to know the state ordering, the
device "knows" what to do here. It's a bit more callbacks than what I
would have liked, but it makes sense still...

The problem is that the only sane way I see for now to properly cascade
these down the tree is recursive calls from bridge enter_state routines,
which may have evil stack consumption issues... Unless somebody comes up
with a smart idea.

I'm also not 100% sure how to fir the system PM in that picture. They'll
end up beeing called when the parent gets it's system PM suspend() for
example, so the only difference here is that the child will already have
suspend()'d before it gets parent_state_will_change() and
parent_state_changed() for it's parent's own suspend(). I suppose that
isn't an issue...

Ben.




--===============50107713590061587==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============50107713590061587==--
